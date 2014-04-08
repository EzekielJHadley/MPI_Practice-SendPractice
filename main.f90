      program main
      use my_constants
      implicit none

      integer:: ierr, nproc, rank
      integer:: msg1 = 0, msg2 = 0
      integer:: stat(MPI_STATUS_SIZE)

      call MPI_INIT(ierr)
      call MPI_COMM_SIZE(MPI_COMM_WORLD,nproc,ierr)
      call MPI_COMM_RANK(MPI_COMM_WORLD,rank,ierr)

      IF (MOD(rank, 2) == 0) THEN
            msg2 = 1
            !send (the data, amount of data, type of data, address,
            !name the message, what comunicator your using)
            call MPI_SEND(msg2, 1, MPI_INTEGER, rank + 1, rank, MPI_COMM_WORLD, & 
                  ierr)
            !now i want the even proc to recieve some data
            call MPI_RECV(msg1, 1, MPI_INTEGER, rank + 1, rank, MPI_COMM_WORLD, &
                  stat, ierr)
            IF (msg1 == 2) THEN
                  print *, "My name is ", rank, " and ", rank + 1, " just told &
				me to sod off"
            ELSE
                  print *, "My name is ", rank, " and no one is talking to me"
            END IF
      END IF

      IF (MOD(rank, 2) == 1) THEN
            msg1 = 2
            !now the odd numbers must first recieve and then send a msg
            call MPI_RECV(msg2, 1, MPI_INTEGER, rank - 1, rank - 1, MPI_COMM_WORLD, &
                  stat, ierr)
            !now send the odd's msg
            call MPI_SEND(msg1, 1, MPI_INTEGER, rank - 1, rank - 1, MPI_COMM_WORLD, &
                        ierr)
            IF (msg2 == 1) THEN
                  print *, "My name is ", rank, " and ", rank - 1, " just told &
				me he loved me"
            END IF
      END IF

      call MPI_FINALIZE(ierr)
      end program main

