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

