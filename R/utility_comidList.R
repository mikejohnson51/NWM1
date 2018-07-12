#' Break COMIDs into sequential lists
#'
#' @param AOI an AOI object
#' @param num the number of desired lists (default 2)
#'
#' @return a list of vectors
#' @export
#' @author Mike Johnson

comidList = function(AOI, num){

  i = NULL
  `%do%` <- foreach::`%do%`

  nhd = findNHD(AOI, spatial = FALSE)

  index = which(nwm::comids_all %in% nhd$comid)

  index = index[!is.na(index)]

  series <- foreach(i = 1:250, .combine = "c") %do% length(getBreaks(index, i))

  if(!(num %in% series)) { num = min(series)}

  xx = getBreaks(index, gap = which(series == num)[1])

  return(xx)
}

