# Interpretation

## Summary of findings

This project performs a count-level RNA-seq differential expression workflow using the Bioconductor `airway` dataset. The analysis compares dexamethasone-treated human airway smooth muscle cell samples against untreated controls.

The workflow loaded 63,677 genes across 8 samples. After low-count filtering, 22,369 genes were tested using DESeq2. At an adjusted p-value threshold of 0.05, 2,694 genes were identified as significantly differentially expressed.

This indicates that dexamethasone treatment produces a substantial transcriptional response in airway smooth muscle cells.

## Biological interpretation

Dexamethasone is a glucocorticoid with strong anti-inflammatory effects and is commonly used in contexts involving airway inflammation. A large number of differentially expressed genes is therefore biologically plausible, as glucocorticoid treatment can alter transcriptional regulation across many immune, inflammatory, metabolic, and cell signalling pathways.

The results suggest that treated and untreated samples differ at the gene expression level, consistent with a treatment-driven transcriptional response.

## Interpretation of the PCA plot

The PCA plot provides an overview of the largest sources of variation in the expression dataset.

If treated and untreated samples separate along one of the principal components, this suggests that dexamethasone treatment explains a meaningful proportion of the variation in gene expression. If samples cluster by treatment group, this supports the presence of a consistent treatment effect across biological replicates.

If any samples appear distant from their treatment group, those samples would be candidates for additional quality control or investigation.

## Interpretation of the DESeq2 results

DESeq2 models count data using a negative binomial framework and estimates differential expression while accounting for biological variability across samples.

The result that 2,694 genes were significant at adjusted p-value < 0.05 suggests broad transcriptional changes between treated and untreated samples. However, statistical significance alone is not enough to determine biological importance. Genes with both strong adjusted significance and large absolute log2 fold change are usually more useful candidates for follow-up interpretation.

The full DESeq2 results table should therefore be interpreted using both:

* adjusted p-value, to assess statistical evidence
* log2 fold change, to assess effect size and direction

## Interpretation of the MA plot

The MA plot shows the relationship between average gene expression and log2 fold change.

Genes near zero on the y-axis show little change between treatment groups. Genes far above or below zero show stronger upregulation or downregulation after dexamethasone treatment.

This plot is useful for checking whether strong fold changes are concentrated among low-count genes or whether they occur across a range of expression levels.

## Interpretation of the volcano plot

The volcano plot combines effect size and statistical significance.

Genes in the upper left and upper right regions are the most interesting candidates because they show both strong fold change and strong statistical evidence. These genes are useful starting points for biological follow-up, gene annotation, or pathway enrichment.

The volcano plot provides a quick visual summary of the overall differential expression landscape.

## Interpretation of the heatmap

The heatmap of the top differentially expressed genes shows whether the strongest gene expression changes separate treated and untreated samples.

If treated samples cluster together and untreated samples cluster together, this supports the conclusion that dexamethasone produces a consistent expression response across replicates.

The heatmap also helps identify groups of genes with similar expression behaviour, which may reflect shared regulation or related biological functions.

## Important limitations

This project is a count-level RNA-seq workflow, not a full raw sequencing workflow. It starts from a prepared count matrix rather than FASTQ files.

Other limitations include:

* the dataset contains only 8 samples
* the analysis does not yet include gene symbol annotation
* the workflow does not yet include pathway enrichment or gene ontology analysis
* the current interpretation is based on statistical output and visualisation rather than experimental validation
* the airway dataset is useful for demonstrating workflow skills but is not a novel biological dataset

## Recommended next extensions

Useful improvements would include:

* adding Ensembl-to-gene-symbol annotation
* extracting the top upregulated and downregulated genes
* adding pathway enrichment analysis
* producing a short biological results report
* turning the workflow into a Snakemake or Quarto-based analysis
* extending the portfolio with a separate raw FASTQ-to-counts workflow

## Overall conclusion

This project demonstrates a standard RNA-seq differential expression workflow using DESeq2. The results show a strong transcriptional response to dexamethasone treatment in airway smooth muscle cells, with thousands of genes showing statistically significant expression changes.

The project provides evidence of practical transcriptomics skills, including data loading, metadata handling, DESeq2 analysis, visualisation, and interpretation of differential expression results.
