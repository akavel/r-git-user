#' Get git user information
#' 
#' \code{git.get.user} retrieves git configuration describing the default user.
#' 
#' @param global if TRUE, retrieves system-global git configuration (i.e. --global);
#' by default, retrieves configuration as used by the current git repository.
#' 
#' @note it requires git to be installed on the system.
#' @note only tested on Windows as of now
git.get.user <- function(global=FALSE) {
  opt_global <- c('--local')
  if (global) {
    opt_global <- c('--global')
  }
  
  name <- system2('git', args=c('config', opt_global, '--get', 'user.name'), stdout=TRUE)
  if (!is.null(attr(name, 'status'))) {
    stop("error running git")
  }
  # TODO: worked for me on windows; make sure on Linux too
  Encoding(name) <- 'UTF-8'
  
  email <- system2('git', args=c('config', opt_global, '--get', 'user.email'), stdout=TRUE)
  if (!is.null(attr(email, 'status'))) {
    stop("error running git")
  }
  return(list(name=name, email=email))
}

#' Set git user information
#' 
#' \code{git.set.user} sets the user name and email to be used by git.
#' 
#' @param name a character string containing full name of the user; e.g. "John Smith"
#' @param email a character string containing email of the user; e.g. "jsmith@@example.com"
#' @param global if TRUE, changes the system-global configuration of git; by default, changes
#' the configuration local to the current git repository.
git.set.user <- function(name, email, global=FALSE) {
  is.character(name) || stop('name must be text, e.g. "John Smith"')
  is.character(email) || stop('email must be text, e.g. "jsmith@example.com"')
  
  opt_global <- c('--local')
  if (global) {
    opt_global <- c('--global')
  }
  
  # TODO: quoting works on windows, but test on Linux too
  # TODO: make sure it works for double quoted: e.g. 'John "Rocket" Smith'
  name <- paste('"', name, '"', sep='')
  out <- system2('git', args=c('config', opt_global, '--replace-all', 'user.name', name), stdout=TRUE)
  if (!is.null(attr(out, 'status'))) {
    stop("error running git")
  }
  
  # TODO: quoting works on windows, but test on Linux too
  # TODO: make sure it works for double quoted: e.g. 'John "Rocket" Smith'
  email <- paste('"', email, '"', sep='')
  out <- system2('git', args=c('config', opt_global, '--replace-all', 'user.email', email), stdout=TRUE)
  if (!is.null(attr(out, 'status'))) {
    stop("error running git")
  }
}

