#! /usr/bin/perl

use strict;
use warnings;

#############################################################################
#----- VARIABLES & SOURCES -------------------------------------------------#
my $input=$ARGV[0]; # Input : directly an ID like "NX_P01308"
if ($input=~ m/h/) 
	{
	print STDERR"--- PROG_protseqstats.pl helper ---\nPROG_protseqstats.pl ARG where ARG should be a protein identifier like \"NX_P01308\"\nGives an output \"ProtSeqStats-ARG.out\" with amino acid frequency\n"; exit;
	}
open (OUT, ">ProtSeqStats-$input.out" || die "Impossible de créer le fichier de sortie! \n"); # Création du fichier de résultats (forme tableau)

##############################################################################
#----- SCRIPT ---------------------------------------------------------------#
print STDERR "Working with $input\n";
# script star by downloading information of the input from nextProt api service
my $query=system('wget -q -O tmp_'.$input.'.txt "https://api.nextprot.org/entry/'.$input.'/isoform.json"');
# now retrieve the sequence from the file
my $checker=0; my $seq = "";
open (TEMP, "tmp_$input.txt" || die "can't open tmp_$input.txt ! \n");
while (<TEMP>)
	{
	chomp $_;
	if ($_=~ m/"uniqueName" : "$input"/g) { $checker = 1;}
	if ($_=~ m/"sequence" : "(.+)"/g && $checker==1) { $seq = $1; goto TEMPEND;}
	}
TEMPEND:
close TEMP;
`rm tmp_$input.txt`;
print STDERR "Sequence retieved $seq\n";
# work on the sequence
my %h_aa; my $totaa=0;
my @tabseq=split("", $seq);
foreach my $aa (@tabseq)
	{
	$totaa++;
	if (!defined $h_aa{$aa}) { $h_aa{$aa}=1;}
		else { $h_aa{$aa}++;}	
	}
# printing results
my $cpt = 0;
my @results_sorted = sort { $h_aa{$b} <=> $h_aa{$a} } keys(%h_aa);
print OUT "Amino Acid\tFrequency\tPercentage\n";
foreach my $key (@results_sorted)
	{
	if ($cpt < 3) { print "$key = $h_aa{$key}\n"; $cpt++;}
	print OUT "$key\t$h_aa{$key}\t";
	my $percent = ($h_aa{$key}*100)/$totaa; $percent=sprintf("%.2f", $percent); print OUT "$percent\n";
	}
close OUT;

