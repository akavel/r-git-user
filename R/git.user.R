git.get.user.global <- function() {
  name <- system2('git', args=c('config', '--get', 'user.name'), stdout=TRUE)
  if (!is.null(attr(name, 'status'))) {
    stop("error running git")
  }
  email <- system2('git', args=c('config', '--get', 'user.email'), stdout=TRUE)
  if (!is.null(attr(email, 'status'))) {
    stop("error running git")
  }
  return(list(name=name, email=email))
}

#git.set.user.global <- function(name, email) {
#  # TODO: check if git is installed and available actually
#}