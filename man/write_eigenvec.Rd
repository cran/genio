% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/write_eigenvec.R
\name{write_eigenvec}
\alias{write_eigenvec}
\title{Write eigenvectors table into a Plink-format file}
\usage{
write_eigenvec(
  file,
  eigenvec,
  fam = NULL,
  ext = "eigenvec",
  plink2 = FALSE,
  verbose = TRUE
)
}
\arguments{
\item{file}{The output file name (possibly without extension)}

\item{eigenvec}{A matrix or tibble containing the eigenvectors to include in the file.
Column names other than \code{fam} and \code{id} can be anything and are all treated as eigenvectors (not written to file).}

\item{fam}{An optional \code{fam} table, which is used to add the \code{fam} and \code{id} columns to \code{eigenvec} (which overwrite columns of the same name in \code{eigenvec} if present, after a warning is produced).
Individuals in \code{fam} and \code{eigenvec} are assumed to be the same and in the same order.}

\item{ext}{Output file extension.
Since the general "covariates" file format in GCTA and Plink are the same as this, this function may be used to write more general covariates files if desired, in which case users may wish to change this extension for clarity.}

\item{plink2}{If \code{TRUE}, prints a header in the style of plink2 (starts with hash, \code{fam} -> \code{FID}, \code{id} -> \code{IID}, and the default PCs are named \code{PC1}, \code{PC2}, etc.
Returned data.frame will also have these names.}

\item{verbose}{If \code{TRUE} (default), function reports the path of the file being written (after autocompleting the extension).}
}
\value{
Invisibly, the final \code{eigenvec} data.frame or tibble written to file, starting with columns \code{fam} and \code{id} (merged from the \code{fam} input, if it was passed) followed by the rest of columns in the input \code{eigenvec}.
Column names are instead \verb{#FID}, \code{IID}, etc if \code{plink2 = TRUE}.
}
\description{
This function writes eigenvectors in Plink 1 (same as GCTA) format (table with no header, with first two columns being \code{fam} and \code{id}), which is a subset of Plink 2 format (which optionally allows column names and does not require fam column).
Main expected case is \code{eigenvec} passed as a numeric matrix and \code{fam} provided to complete first two missing columns.
However, input \code{eigenvec} may also be a data.frame already containing the \code{fam} and \code{id} columns, and other reasonable intermediate cases are also handled.
If both \code{eigenvec} and \code{fam} are provided and contain overlapping columns, those in \code{eigenvec} get overwritten with a warning.
}
\examples{
# to write an existing matrix `eigenvec` and optional `fam` tibble into file "data.eigenvec",
# run like this:
# write_eigenvec("data", eigenvec, fam = fam)
# this also works
# write_eigenvec("data.eigenvec", eigenvec, fam = fam)

# The following example is more detailed but also more awkward
# because (only for these examples) the package must create the file in a *temporary* location

# create dummy eigenvectors matrix, in this case from a small identity matrix
# number of individuals
n <- 10
eigenvec <- eigen( diag( n ) )$vectors
# subset columns to use top 3 eigenvectors only
eigenvec <- eigenvec[ , 1:3 ]
# dummy fam data
library(tibble)
fam <- tibble( fam = 1:n, id = 1:n )

# write this data to .eigenvec file
# output path without extension
file <- tempfile('delete-me-example')
eigenvec_final <- write_eigenvec( file, eigenvec, fam = fam )
# inspect the tibble that was written to file (returned invisibly)
eigenvec_final

# remove temporary file (add extension before deletion)
file.remove( paste0( file, '.eigenvec' ) )

}
\seealso{
\code{\link[=read_eigenvec]{read_eigenvec()}} for reading an eigenvec file.

Plink 1 eigenvec format reference:
\url{https://www.cog-genomics.org/plink/1.9/formats#eigenvec}

Plink 2 eigenvec format reference:
\url{https://www.cog-genomics.org/plink/2.0/formats#eigenvec}

GCTA eigenvec format reference:
\url{https://cnsgenomics.com/software/gcta/#PCA}
}
