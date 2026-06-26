# 01_load_airway_data.R
# Load the Bioconductor airway RNA-seq dataset and export count matrix and sample metadata.

suppressPackageStartupMessages({
  library(airway)
  library(SummarizedExperiment)
})

dir.create("data/processed", recursive = TRUE, showWarnings = FALSE)
dir.create("results/tables", recursive = TRUE, showWarnings = FALSE)

data("airway")

counts <- assay(airway)
metadata <- as.data.frame(colData(airway))

# Keep sample IDs explicit
metadata$sample_id <- rownames(metadata)

# Export processed inputs for downstream scripts
write.csv(counts, "data/processed/airway_counts.csv", quote = FALSE)
write.csv(metadata, "data/processed/airway_metadata.csv", row.names = FALSE, quote = FALSE)

# Save full SummarizedExperiment object
saveRDS(airway, "data/processed/airway_summarized_experiment.rds")

summary_table <- data.frame(
  metric = c(
    "number_of_genes",
    "number_of_samples",
    "treated_samples",
    "untreated_samples"
  ),
  value = c(
    nrow(counts),
    ncol(counts),
    sum(metadata$dex == "trt"),
    sum(metadata$dex == "untrt")
  )
)

write.csv(summary_table, "results/tables/airway_dataset_summary.csv", row.names = FALSE)

cat("Loaded airway dataset successfully\n")
cat("Genes:", nrow(counts), "\n")
cat("Samples:", ncol(counts), "\n")
cat("Processed files written to data/processed/\n")
