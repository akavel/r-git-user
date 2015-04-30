git.get.user.global <- function() {
  name <- system2('git', args=c('config', '--get', 'user.name'), stdout=TRUE)
  if (!is.null(attr(name, 'status'))) {
    stop("error running git")
  }
  # TODO: worked for me on windows; make sure on Linux too
  Encoding(name) <- 'UTF-8'
  
  email <- system2('git', args=c('config', '--get', 'user.email'), stdout=TRUE)
  if (!is.null(attr(email, 'status'))) {
    stop("error running git")
  }
  return(list(name=name, email=email))
}

git.set.user.global <- function(name, email) {
  # TODO: quoting works on windows, but test on Linux too
  # TODO: make sure it works for double quoted: e.g. 'John "Rocket" Smith'
  name <- paste('"', name, '"', sep='')
  out <- system2('git', args=c('config', '--global', '--replace-all', 'user.name', name), stdout=TRUE)
  if (!is.null(attr(out, 'status'))) {
    stop("error running git")
  }
  
  # TODO: quoting works on windows, but test on Linux too
  # TODO: make sure it works for double quoted: e.g. 'John "Rocket" Smith'
  email <- paste('"', email, '"', sep='')
  out <- system2('git', args=c('config', '--global', '--replace-all', 'user.email', email), stdout=TRUE)
  if (!is.null(attr(out, 'status'))) {
    stop("error running git")
  }
}

# TODO: add default local versions of the commands, with optional 'global=TRUE' parameter
