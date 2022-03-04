# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    makefile                                           :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: gson <gson@student.42seoul.kr>             +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2021/11/15 06:00:19 by gson              #+#    #+#              #
#    Updated: 2021/11/21 23:27:11 by gson             ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

SERVER = server
CLIENT = client

SRC_DIR = ./src/
INC_DIR = ./include/

SERVER_SRC = minitalk_server.c
CLIENT_SRC = minitalk_client.c

SERVER_SRCS = $(addprefix $(SRC_DIR), $(SERVER_SRC))
CLIENT_SRCS = $(addprefix $(SRC_DIR), $(CLIENT_SRC))

SERVER_OBJS = $(SERVER_SRCS:.c=.o)
CLIENT_OBJS = $(CLIENT_SRCS:.c=.o)

LIBS	 = -L./libft -lft

CC = gcc

RM = rm -f

CFLAGS = -Wall -Wextra -Werror -g

$(SERVER) : $(SERVER_OBJS)
		make -C libft
		$(CC) -o $(SERVER) $(SERVER_OBJS) $(LIBS)

$(CLIENT) : $(CLIENT_OBJS)
		make -C libft
		$(CC) -o $(CLIENT) $(CLIENT_OBJS) $(LIBS)

%.o: %.c
		gcc $(CFLAGS) -I $(INC_DIR) -c $< -o $@

all : $(SERVER) $(CLIENT)

clean :
		make -C libft clean
		rm -f $(SERVER_OBJS) $(CLIENT_OBJS)

fclean : clean
		make -C libft fclean
		rm -f $(SERVER) $(CLIENT)

re: fclean all

.PHONY : all clean fclean re
