% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/read_grm.R
\name{read_grm}
\alias{read_grm}
\title{Read GCTA GRM and related plink2 binary files}
\usage{
read_grm(
  name,
  n_ind = NA,
  verbose = TRUE,
  ext = "grm",
  shape = c("triangle", "strict_triangle", "square"),
  size_bytes = 4,
  comment = "#"
)
}
\arguments{
\item{name}{The base name of the input files.
Files with that base, plus shared extension (default "grm", see \code{ext} below), plus extensions \code{.bin}, \code{.N.bin}, and \code{.id} are read if they exist.
Only \verb{.<ext>.bin} is absolutely required; \verb{.<ext>.id} can be substituted by the number of individuals (see below); \verb{.<ext>.N.bin} is entirely optional.}

\item{n_ind}{The number of individuals, required if the file with the extension \verb{.<ext>.id} is missing.
If the file with the \verb{.<ext>.id} extension is present, then this \code{n_ind} is ignored.}

\item{verbose}{If \code{TRUE} (default), function reports the path of the files being loaded.}

\item{ext}{Shared extension for all three inputs (see \code{name} above; default "grm").
Another useful value is "king" for KING-robust estimates produced by plink2.
If \code{NA}, no extension is added.
If given \code{ext} is also present at the end of \code{name}, then it is not added again.}

\item{shape}{The shape of the information to read (may be abbreviated).
Default "triangle" assumes there are \code{n*(n+1)/2} values to read corresponding to the upper triangle including the diagonal (required for GCTA GRM).
"strict_triangle" assumes there are \code{n*(n-1)/2} values to read corresponding to the upper triangle \emph{excluding} the diagonal (best for plink2 KING-robust).
Lastly, "square" assumes there are \code{n*n} values to read corresponding to the entire square matrix, ignoring symmetry.}

\item{size_bytes}{The number of bytes per number encoded.
Default 4 corresponds to GCTA GRM and plink2 "bin4", whereas plink2 "bin" requires a value of 8.}

\item{comment}{Character to start comments in \verb{<ext>.id} file only.
Default "#" helps plink2 \code{.id} files (which have a header that starts with "#", which is therefore ignored) be read just like plink1 and GCTA files (which do not have a header).}
}
\value{
A list with named elements:
\itemize{
\item \code{kinship}: The symmetric \code{n}-times-\code{n} kinship matrix (GRM).  Has IDs as row and column names if the file with extension \verb{.<ext>.id} exists.  If \code{shape='strict_triangle'}, diagonal will have missing values.
\item \code{M}: The symmetric \code{n}-times-\code{n} matrix of pair sample sizes (number of non-missing loci pairs), if the file with extension \verb{.<ext>.N.bin} exists.  Has IDs as row and column names if the file with extension \verb{.<ext>.id} was available.  If \code{shape='strict_triangle'}, diagonal will have missing values.
\item \code{fam}: A tibble with two columns: \code{fam} and \code{id}, same as in Plink FAM files.  Returned if the file with extension \verb{.<ext>.id} exists.
}
}
\description{
This function reads a GCTA Genetic Relatedness Matrix (GRM, i.e. kinship) set of files in their binary format, returning the kinship matrix and, if available, the corresponding matrix of pair sample sizes (non-trivial under missingness) and individuals table.
Setting some options allows reading plink2 binary kinship formats such as "king" (see examples).
}
\examples{
# to read "data.grm.bin" and etc, run like this:
# obj <- read_grm("data")
# obj$kinship # the kinship matrix
# obj$M       # the pair sample sizes matrix
# obj$fam     # the fam and ID tibble

# The following example is more awkward
# because package sample data has to be specified in this weird way:

# read an existing set of GRM files
file <- system.file("extdata", 'sample.grm.bin', package = "genio", mustWork = TRUE)
file <- sub('\\\\.grm\\\\.bin$', '', file) # remove extension from this path on purpose
obj <- read_grm(file)
obj$kinship # the kinship matrix
obj$M       # the pair sample sizes matrix
obj$fam     # the fam and ID tibble

# Read sample plink2 KING-robust files (several variants).
# Read both base.king.bin and base.king.id files.
# All generated with "plink2 <input> --make-king <options> --out base"
# (replace "base" with actual base name) with these options:
# #1) "triangle bin"
# data <- read_grm( 'base', ext = 'king', shape = 'strict', size_bytes = 8 )
# #2) "triangle bin4"
# data <- read_grm( 'base', ext = 'king', shape = 'strict' )
# #3) "square bin"
# data <- read_grm( 'base', ext = 'king', shape = 'square', size_bytes = 8 )
# #4) "square bin4"
# data <- read_grm( 'base', ext = 'king', shape = 'square' )

}
\seealso{
\code{\link[=write_grm]{write_grm()}}

Greatly adapted from sample code from GCTA:
\url{https://cnsgenomics.com/software/gcta/#MakingaGRM}
}
