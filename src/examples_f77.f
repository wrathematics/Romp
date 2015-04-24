      SUBROUTINE F77HLO()
      INTEGER TID, NTHREADS
      include 'omp_lib.h'
      
C$OMP PARALLEL PRIVATE(TID)
      NTHREADS = OMP_GET_NUM_THREADS()
      TID = OMP_GET_THREAD_NUM()
      
      CALL INTPR("HELLO FROM THREAD", -1, TID, 1)
C$OMP END PARALLEL
      END SUBROUTINE



      SUBROUTINE F77SUM(X, XLEN, S)
      INTEGER XLEN
      DOUBLE PRECISION X(XLEN), S
      INTEGER I
      
      S = 0.0D0
C$OMP PARALLEL DO DEFAULT(SHARED) PRIVATE(I) REDUCTION(+:S)
      DO 10, I=1, XLEN
        S = S + X(I)
 10   CONTINUE
C$OMP END PARALLEL DO
      END SUBROUTINE



      SUBROUTINE F77SWP(M, N, X, VEC, RET)
      INTEGER M, N
      DOUBLE PRECISION X(M, N), VEC(M), RET(M, N)
      INTEGER I, J
      
C$OMP PARALLEL DO DEFAULT(SHARED) PRIVATE(I, J)
      DO 10, J=1, N
        DO 20, I=1, M
          RET(I, J) = X(I, J) - VEC(I)
 20     CONTINUE
 10   CONTINUE
C$OMP END PARALLEL DO
      END SUBROUTINE



      SUBROUTINE F77PB(N, NPRIMES)
      INTEGER N, NPRIMES
      INTEGER I, J, ISPRIME
      INTRINSIC MOD
      
      NPRIMES = 1
      
C$OMP PARALLEL DO PRIVATE(ISPRIME) REDUCTION(+:NPRIMES)
      DO 10, I=3, N, 2
        ISPRIME = 1
        
        DO 20, J=3, I-1, 2
          IF (MOD(I, J).EQ.0) THEN
            ISPRIME = 0
            EXIT
          END IF
 20     CONTINUE
        IF (ISPRIME.EQ.1) NPRIMES  = NPRIMES+1
 10   CONTINUE
      END SUBROUTINE

