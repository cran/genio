#' Write Plink *.bim files
#' 
#' This function writes a tibble with the right columns into a standard Plink *.bim file.
#' It uses [readr::write_tsv()] to do it efficiently.
#' 
#' @param file Output file (whatever is accepted by [readr::write_tsv()]).
#' If file is missing the expected *.bim extension, the function adds it.
#' @param tib The tibble or data.frame to write.
#' It must contain these columns: `chr`, `id`, `posg`, `pos`, `alt`, `ref`.
#' Throws an error if any of these columns are missing.
#' Additional columns are ignored.
#' Columns are automatically reordered in output as expected in format.
#' @param verbose If `TRUE` (default), function reports the path of the file being written (after autocompleting the extension).
#' @param append If `TRUE`, appends rows onto the file. (Default is `FALSE`).
#'
#' @return The output `tib` invisibly (what [readr::write_tsv()] returns).
#'
#' @examples
#' # to write an existing table `bim` into file "data.bim", run like this:
#' # write_bim("data", bim)
#' # this also works
#' # write_bim("data.bim", bim)
#' 
#' # The following example is more detailed but also more awkward
#' # because (only for these examples) the package must create the file in a *temporary* location
#' 
#' # create a dummy tibble with the right columns
#' library(tibble)
#' tib <- tibble(
#'     chr = 1:3,
#'     id = 1:3,
#'     posg = 0,
#'     pos = 1:3,
#'     alt = 'B',
#'     ref = 'A'
#' )
#' # a dummy file
#' file_out <- tempfile('delete-me-example', fileext = '.bim') # will also work without extension
#' # write the table out in *.bim format (no header, columns in right order)
#' write_bim(file_out, tib)
#' 
#' # example cleanup
#' file.remove(file_out)
#' 
#' @seealso
#' [write_plink()] for writing a set of BED/BIM/FAM files.
#' 
#' Plink BIM format references:
#' <https://www.cog-genomics.org/plink/1.9/formats#bim>
#' <https://www.cog-genomics.org/plink/2.0/formats#bim>
#'
#' @export
write_bim <- function(file, tib, verbose = TRUE, append = FALSE) {
    # this generic writer does all the magic
    write_tab_generic(
        file = file,
        tib = tib,
        ext = 'bim',
        tib_names = bim_names,
        verbose = verbose,
        append = append
    )
}
