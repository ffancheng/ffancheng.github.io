##---------------------------------------------------
# All quality measures in a function
##---------------------------------------------------
dr_quality <- function(X, Y, pars){
  if (!is.list(pars))         stop("pars must be a list consists of knn and epsilon")
  if (dim(X)[1] != dim(Y)[1]) stop("X and Y must have the same rows!")
  
  ## coRanking matrix Q
  Q <- coRanking::coranking(Y, X)
  N <- nrow(Q) + 1
  K <- pars$knn
  
  # Trustworthiness & Continuity
  M_T <- coRanking:::cm.M_T(Q, K = K)
  M_C <- coRanking:::cm.M_C(Q, K = K)
  
  # Mean Relative Rank Errors
  W_n <- coRanking:::cm.W_n(Q, K = K)
  W_nu <- coRanking:::cm.W_nu(Q, K = K)
  
  # Local Continuity Meta-Criterion
  lcmc <- coRanking::LCMC(Q, K = as.integer(K))
  # OR: coRanking:::cm.K_max(Q)$K_max
  
  # Co-ranking Matrix
  Qnx <- sum(Q[1:K, 1:K]) / K / N
  # Qnx <- dimRed::Q_NX(sr_isomap)
  Qlocal <- dimRed::quality(sr_isomap, "Q_local")
  Qglobal <- dimRed::quality(sr_isomap, "Q_global")
  Rnx <- ((N - 1) * Qnx - K) / (N - 1 - K)
  # Rnx <- dimRed::R_NX(sr_isomap)
  mean_Rnx <- dimRed::quality(sr_isomap, "mean_R_NX")
  auc_lnK_Rnx <- dimRed::quality(sr_isomap, "AUC_lnK_R_NX")
  K_optim <- as.numeric(names(Qglobal))
  
  return(list(X = X, Y = Y, N = N, pars = pars, Q = Q, 
              quality=data.frame(K = K_optim, M_T=M_T, M_C=M_C, W_n=W_n, W_nu=W_nu, lcmc=lcmc,
                                 Qnx=Qnx, Qlocal=Qlocal, Qglobal=Qglobal,
                                 Rnx=Rnx, mean_Rnx=mean_Rnx, auc_lnK_Rnx=auc_lnK_Rnx, 
                                 row.names = ""
                                 )))
}

## test
# sr <- dimRed::loadDataSet("Swiss Roll", n = 2000, sigma = 0.05)
# sr_isomap <- dimRed::embed(sr, "Isomap", knn = 50, ndim = 2, get_geod = FALSE)
# X <- as.matrix(sr_isomap@org.data); Y <- sr_isomap@data@data
# pars <- sr_isomap@pars

# tictoc::tic()
# quality_list <- dr_quality(X, Y, pars)
# tictoc::toc()
# # 12.401 sec elapsed
# # View(quality_list)
# qualities <- quality_list$quality



##------------------------------------------------------
## Procrustes measure R(X, Y)
##------------------------------------------------------
# R(X, Y) = 1/n \sum_{i=1}{n} {G(X_i, Y_i)},
# where G(X_i, Y_i) is the Procrustes statistics of X_i and Y_i.
# X: n*q, n samples of q dimension
# Y: n*d, d-dimensional embedding of X, d << q
# X_i: neighborhood of x_i (i = 1, ..., n)
# Y_i: embedding of X_i
proc.measure <- function(X, Y, pars, treetype = "kd", searchtype = "standard"){
  # neighborhood
  ## each row consists of c(row index i, neighbors index) 
  nnidx <- RANN::nn2(data = X, query = X, k = pars$knn + 1, eps = pars$eps, 
                     treetype = "kd", searchtype = "standard")$nn.idx[, -1]
  # calculate R(X,Y)
  G <- list()
  R_XY <- c()
  for(i in 1:pars$knn){
    Xi <- X[nnidx[i, ], , drop = FALSE]
    Yi <- Y[nnidx[i, ], , drop = FALSE]
    # calculate G(X_i, Y_i)
    G[[i]] <- invisible(vegan::procrustes(Xi, Yi))
    R_XY[i] <- G[[i]]$ss
  }
  R <- sum(R_XY)
  message("The Procrustes measure R(X,Y) is ", R)
  result <- list(G_XY = G, R_i = R_XY, R = R)
  return(result)
}

# # test
# PM <- proc.measure(X, Y, pars = sr_isomap@pars)
# plot(PM$R_i, type = "h", xlab = "Index of neighborhood k", ylab = "Procrustes statistics G(X,Y)")
# # find the optim K
# which.min(PM$R_i)
# # [1] 21
# # PM1 <- proc.measure(X, Y, pars = list(knn=which.min(PM$R_i), eps=0))
