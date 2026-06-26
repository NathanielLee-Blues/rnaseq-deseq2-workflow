# 03_visualisation.R
# Generate PCA, MA, volcano, and heatmap plots from DESeq2 outputs.

suppressPackageStartupMessages({
  library(DESeq2)
  library(ggplot2)
  library(ggrepel)
  library(pheatmap)
})

dir.create("figures", recursive = TRUE, showWarnings = FALSE)

dds <- readRDS("data/processed/deseq2_dds.rds")
res_df <- read.csv("results/tables/deseq2_results_treated_vs_untreated.csv")

vsd <- vst(dds, blind = FALSE)

# PCA plot
pca_data <- plotPCA(vsd, intgroup = "dex", returnData = TRUE)
percent_var <- round(100 * attr(pca_data, "percentVar"))

p_pca <- ggplot(pca_data, aes(PC1, PC2, colour = dex)) +
  geom_point(size = 4) +
  xlab(paste0("PC1: ", percent_var[1], "% variance")) +
  ylab(paste0("PC2: ", percent_var[2], "% variance")) +
  theme_minimal() +
  ggtitle("PCA of airway RNA-seq samples")

ggsave("figures/pca_plot.png", p_pca, width = 7, height = 5, dpi = 300)

# MA plot
png("figures/ma_plot.png", width = 2000, height = 1600, res = 300)
plotMA(results(dds, contrast = c("dex", "trt", "untrt")),
       main = "MA plot: treated vs untreated",
       ylim = c(-5, 5))
dev.off()

# Volcano plot
volcano_df <- res_df
volcano_df$significant <- ifelse(
  !is.na(volcano_df$padj) & volcano_df$padj < 0.05 & abs(volcano_df$log2FoldChange) > 1,
  "Significant",
  "Not significant"
)

volcano_df$neg_log10_padj <- -log10(volcano_df$padj)
volcano_df$neg_log10_padj[is.infinite(volcano_df$neg_log10_padj)] <- NA

p_volcano <- ggplot(volcano_df, aes(x = log2FoldChange, y = neg_log10_padj, colour = significant)) +
  geom_point(alpha = 0.7) +
  theme_minimal() +
  xlab("log2 fold change") +
  ylab("-log10 adjusted p-value") +
  ggtitle("Volcano plot: dexamethasone treated vs untreated") +
  theme(legend.title = element_blank())

ggsave("figures/volcano_plot.png", p_volcano, width = 7, height = 5, dpi = 300)

# Heatmap of top 30 differentially expressed genes
top_genes <- res_df$gene_id[!is.na(res_df$padj)][1:30]
vst_matrix <- assay(vsd)
heatmap_matrix <- vst_matrix[top_genes, ]

# Row-scale for visualisation
heatmap_matrix_scaled <- t(scale(t(heatmap_matrix)))

annotation_col <- as.data.frame(colData(dds)[, "dex", drop = FALSE])

png("figures/top30_gene_heatmap.png", width = 2200, height = 2200, res = 300)
pheatmap(
  heatmap_matrix_scaled,
  annotation_col = annotation_col,
  show_rownames = FALSE,
  main = "Top 30 differentially expressed genes"
)
dev.off()

cat("Figures generated successfully\n")
cat("Outputs saved to figures/\n")
