-*/fontawesome-pro-5.14.0-web/*, -/*/css/lib/*, -*/js/lib/jquery-2.2.1.*, -/*public/js/lib/turbolinks.js/*, -*/js/lib/bootstrap3.js, -*css/assistant_font.css, -*js/lib/linkify.min.js, -*lib/vue.js, -*public/lib/*, -*public/js/lib*

Next steps Nov 21 
=================
* Send emails upon project creation, submission 
* Admin view of all projects 
* Admin view of user project 
* Region preserve selector 
* List of enzymes
* List of users

Guy's Feedback
1. Default for signal peptide and linker = no 
2. Host selection from a drop down menu - Guy will send list of hosts
4. Guy to send Sella list of restriction enzymes to avoid
5. Prevent multiple genes with the same name
6. In add variant view - Host should be user selected gene host (pulled from input)
7. Output: Genes arranged as tabs in each project. Each tab has a list of variants.
8. For each variant add: Add translation to amino acids, position, scroll bar, optimized for, expression modifiers

9. Download options: Each variant with its sequence and metrics, or all project genes and variants with metrics all as .csv files

3. Include vector based optimization - when checked, allow uploading text files

10. Email notification for admin and for user.
11. Admin view.
12. UI
13. For input: remove spaces and new lines,
14. Return error if input includes characters other than 'A','C','G','T','a','c','g',t'
15. Add regions to exclude

- photoshoot

** Excel ** 
<< High >>
* Host selection alphabetically from a drop down menu - Guy will send list of hosts (+host input second after gene name input)
* Support restriction enzymes as list (Maoz needs to receive just the name)
* Prevent multiple genes with the same name
* Output: Genes arranged as tabs in each project. Each tab has a list of variants.
* For each variant add: Add translation to amino acids (in row below the DNA sequence, also for ORF nucleotide seq. as in mock)
* For each variant add: add position (also for both DNA sequence inputs, as in mock)
* For each variant add: Add scroll bar

* Download options- project: All project genes and variants all in a single csv file. 
Columns: project_name, gene_name, variant_number, host_name, sequence (combined utr+ORF)

* Email notification for admin - when user creates project, submits project
* Admin can see and update all projects from all users.
* Input processing: Return error if input includes characters other than 'A','C','G','T','a','c','g',t'
* Add multiple regions to exclude as a click-n-drag, with a "+" button to add more regions. Part of the UI

<< Med >>
Include vector based optimization - support SnapGene & GenBank files
In add variant view - Host should be user selected gene host (pulled from input)
For each variant add: Add optimized for which host
For each variant add: Add expression modifiers: GC content relative to host and input GC content (ORF only)
For each variant add: Add expression modifiers: CAI (ORF only for input and variant) relative to host proteins 
For each variant add: Add expression modifiers: tAI as above
For each variant add: Add expression modifiers: mean deltaG (-33, +33) over windows sized 39bp compared to input
Download options- single variant: the variant with its sequence and metrics. This single variant in the following CSV format:
Columns: project_name, gene_name, variant_number, host_name, sequence (combined utr+ORF)
Input processing: remove spaces and newline characters
 Email notification for user
Default for signal peptide and linker = no
Implement Nony's UI scheme
