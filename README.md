# RNA-seq Differential Expression Workflow with DESeq2

![R](https://img.shields.io/badge/R-DESeq2-blue)
![Bioinformatics](https://img.shields.io/badge/Bioinformatics-RNA--seq-purple)
![Status](https://img.shields.io/badge/Status-In%20development-lightgrey)

## Project overview

This repository demonstrates a reproducible RNA-seq differential expression workflow using R and DESeq2.

The project analyses gene-level RNA-seq count data from the Bioconductor `airway` dataset, comparing dexamethasone-treated and untreated human airway smooth muscle cells.

This project is intended to demonstrate core transcriptomics skills, including count matrix handling, metadata inspection, differential expression analysis, visualisation, and biological interpretation.

## Aim

To identify differentially expressed genes between treated and untreated airway smooth muscle cell samples using a standard RNA-seq differential expression workflow.

## Workflow

```text
RNA-seq count data
        ↓
Sample metadata inspection
        ↓
DESeq2 dataset construction
        ↓
Normalisation and differential expression testing
        ↓
PCA / MA plot / volcano plot / heatmap
        ↓
Biological interpretation
```

Repository structure
```text
rnaseq-deseq2-workflow/
├── data/
│   ├── raw/
│   └── processed/
├── scripts/
│   ├── 01_load_airway_data.R
│   ├── 02_deseq2_analysis.R
│   └── 03_visualisation.R
├── figures/
├── results/
│   └── tables/
├── docs/
│   ├── PROJECT_PLAN.md
│   └── METHODS.md
├── environment.yml
└── README.md
```
Planned outputs

This project will generate:

processed count matrix
sample metadata table
DESeq2 results table
PCA plot
MA plot
volcano plot
heatmap of top differentially expressed genes
short interpretation of key findings
Skills demonstrated
RNA-seq differential expression analysis
DESeq2 workflow design
count matrix and metadata handling
data normalisation
exploratory data visualisation
statistical testing in R
biological interpretation of gene expression results
reproducible GitHub project organisation