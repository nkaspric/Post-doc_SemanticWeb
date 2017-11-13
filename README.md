# Technical Assignment for Post-doctoral position in Bioinformatics and Semantic web technologies :floppy_disk:

### EXO1 - Coding exercise
<p>Perl script "PROG_protseqstats.pl ARG" where ARG should be a protein identifier like "NX_P01308"
Gives an output "ProtSeqStats-ARG.out" with amino acid frequency</p>


### EXO2 - Web Semantic Exercise
<p>neXtProt SPARQL environment request</p>
<p>
SELECT distinct ?geneName ?len<br/>
WHERE<br/>
	{<br/>
	?entry :isoform ?iso .<br/>
	?iso :swissprotDisplayed true .<br/>
	?entry :gene / :name ?geneName .<br/>
	? iso :sequence / :length ?len .<br/>
	}<br/>
ORDER BY DESC (?len)<br/>
LIMIT 3
</p>


### EXO3 - Enhancement(s)


### EXO4 - Bonus question - Federated Queries (optional)

