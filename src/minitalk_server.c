/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   minitalk_server.c                                  :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: gson <gson@student.42seoul.kr>             +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2022/02/25 19:20:33 by gson              #+#    #+#             */
/*   Updated: 2022/03/04 18:21:20 by gson             ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#include "minitalk.h"
#include "libft.h"

void	handler(int	signo, siginfo_t *info, void *context)
{
	static int				i = 0;
	static unsigned char	c = 0;
	static int				pid = 0;

	(void)context;
	pid = info->si_pid;
	if (i == 8)
	{
		ft_putchar_fd(c, 1);
		if (c != 0)
			kill(pid, SIGUSR1);
		else
			kill(pid, SIGUSR2);
		c = 0;
		i = 0;
	}
	if (i < 8)
	{
		if (signo == SIGUSR1)
			c |= 1;
		if (i != 7)
			c <<= 1;
		i++;
	}
}

void	print_pid(pid_t pid)
{
	ft_putstr_fd("SERVER PID : ", 1);
	ft_putnbr_fd(pid, 1);
	ft_putchar_fd('\n', 1);
}

int	main(void)
{
	pid_t				pid;
	struct sigaction	act;

	pid = getpid();
	print_pid(pid);
	act.sa_flags = SA_SIGINFO;
	act.sa_handler = handler;
	sigaction(SIGUSR1, &act, (struct sigaction *) NULL);
	sigaction(SIGUSR2, &act, (struct sigaction *) NULL);
	while (1)
		pause();
	return (0);
}
