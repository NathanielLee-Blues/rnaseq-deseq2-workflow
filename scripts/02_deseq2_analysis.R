# 02_deseq2_analysis.R
# Run DESeq2 differential expression analysis on the airway dataset.

suppressPackageStartupMessages({
  library(DESeq2)
  library(readr)
})

dir.create("results/tables", recursive = TRUE, showWarnings = FALSE)
dir.create("data/processed", recursive = TRUE, showWarnings = FALSE)

counts <- read.csv("data/processed/airway_counts.csv", row.names = 1, check.names = FALSE)
metadata <- read.csv("data/processed/airway_metadata.csv", check.names = FALSE)

rownames(metadata) <- metadata$sample_id

# Ensure count matrix columns match metadata rows
counts <- counts[, rownames(metadata)]

metadata$dex <- factor(metadata$dex)
metadata$dex <- relevel(metadata$dex, ref = "untrt")

dds <- DESeqDataSetFromMatrix(
  countData = round(as.matrix(counts)),
  colData = metadata,
  design = ~ dex
)

# Remove genes with very low counts
keep <- rowSums(counts(dds)) >= 10
dds <- dds[keep, ]

dds <- DESeq(dds)

res <- results(dds, contrast = c("dex", "trt", "untrt"))
res_df <- as.data.frame(res)
res_df$gene_id <- rownames(res_df)

res_df <- res_df[order(res_df$padj), ]

normalised_counts <- counts(dds, normalized = TRUE)
vst_counts <- assay(vst(dds, blind = FALSE))

write.csv(res_df, "results/tables/deseq2_results_treated_vs_untreated.csv", row.names = FALSE)
write.csv(normalised_counts, "data/processed/airway_normalised_counts.csv", quote = FALSE)
write.csv(vst_counts, "data/processed/airway_vst_counts.csv", quote = FALSE)

saveRDS(dds, "data/processed/deseq2_dds.rds")

cat("DESeq2 analysis completed successfully\n")
cat("Genes tested:", nrow(res_df), "\n")
cat("Significant genes at adjusted p < 0.05:", sum(res_df$padj < 0.05, na.rm = TRUE), "\n")
