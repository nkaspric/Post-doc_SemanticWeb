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
	?iso :sequence / :length ?len .<br/>
	}<br/>
ORDER BY DESC (?len)<br/>
LIMIT 3
</p>


### EXO3 - Enhancement(s)
<p>In my previous projects, I have been able to use APIs similar to nextProt. The examples available on the website are very explicit, it allow you to test your query directly on the website and then implement your script with the API links. The proposed formats are commonly used in other applications and are therefore easily reusable. I often work with Uniprot and I find their format "text" (.txt - http://www.uniprot.org/uniprot/P01308.txt) light, very easy to use and to read especially for non-programmer public .<br/>
<br/>
As a non expert web semantic developer, I found the use of your SPARQL point easy. By helping me with the datamodel I was able to reconstruct the requested query and tester some other queries (using the query viewer). The return of the results is fast, the examples are simples and give you the keys to understand correctly how to make your own requests.
</p>



### EXO4 - Bonus question - Federated Queries (optional)
<p>
I am not an expert of SPARQL so i decided to made a query to display neXtProt entries using Uniprot ressource.<br/>
On the Uniprot SPARQL query builder, there is a request to generate all the UniProt entries, and their recommended protein name, that have a preferred gene name that contains the text 'DNA' (prebuild query). I integrated this query into a very simple request of neXtProt to display the neXtProt entry.
At this point I encountered several problems to display the results. Indeed, there was no link between my uniprot results and nextProt entries.<br/>
So I looked at the Uniprot and neXtProt datamodels and I see a link thank's to "skos:exactMatch" method.
</p>
<br/>
<p>
PREFIX up:<http://purl.uniprot.org/core/><br/>
PREFIX skos:<http://www.w3.org/2004/02/skos/core#><br/>
SELECT DISTINCT ?entry<br/>
where<br/>
	{<br/>
	SERVICE <http://sparql.uniprot.org/sparql><br/>
		{<br/>
		SELECT ?protein ?anme<br/>
		WHERE<br/>
			{<br/>
			?protein a up:Protein .<br/>
			?protein up:recommendedName ?recommended .<br/>
			?recommended up:fullName ?name .<br/>
			?protein up:encodedBy ?gene .<br/>
			?gene skos:prefLabel ?text .<br/>
			FILTER CONTAINS(?text, 'DNA') .<br/>
			}<br/>
		}<br/>
	?entry skos:exactMatch ?protein .<br/>
	}<br/>
LIMIT 10<br/>
</p>
