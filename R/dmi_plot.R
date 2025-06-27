#' Plot Hybrid Fitness of a Dobzhansky-Muller Incompatibility
#'
#' @param h2 Fitness of an alternate ancestry homozygous genotype
#' @param h1 Fitness of a homozygous x heterozygous genotype
#' @param h0 Fitness of a double heterozygote genotype
#'
#' @return A filled contour plot of fitness across hybrid genotypic space
#' @export

dmi_plot <- function(h2, h1, h0){
  p2 <- seq(0, 1, l = 300)
  ph <- seq(0, 1, l = 300)

  hyb_genos <- expand.grid(p2, ph)

  colnames(hyb_genos) <- c("p2", "ph")

  triang <- data.frame(x = c(0,.5,1), xend = c(.5,1,0),
                       y = c(0,1,0), yend = c(1,0,0))

  hyb_genos |>
    dplyr::filter(p2 <= .5 & ph <= 2*p2 | p2 > .5 & ph < 2*(1-p2)) |>
    dplyr::mutate(p22 = p2 - .5*ph,
                  p11 = 1 - p22 - ph,
                  fit = 1 - (p11*p22*h2 + (p11 + p22)*ph*h1 + ph^2*h0)) |>
    ggplot2::ggplot(ggplot2::aes(x = p2, y = ph, z = fit)) +
    metR::geom_contour_fill() +
    ggplot2::scale_fill_viridis_c() +
    ggplot2::geom_segment(data = triang, ggplot2::aes(x = x, y = y,
                                                      xend = xend,
                                                      yend = yend),
                          inherit.aes = F,
                          linewidth = 2,
                          color = "grey",
                          lineend = "round") +
    ggplot2::labs(x = "Ancestry Proportion",
         y = "Ancestry Heterozygosity",
         fill = "Mean Survival Probability") +
    ggplot2::theme_minimal() +
    ggplot2::theme(legend.position = "bottom",
                   legend.title.position = "bottom",
                   legend.key.size = ggplot2::unit(50, "pt"),
                   legend.key.height = ggplot2::unit(10, "pt"),
                   legend.title = ggplot2::element_text(hjust = .5))
}
