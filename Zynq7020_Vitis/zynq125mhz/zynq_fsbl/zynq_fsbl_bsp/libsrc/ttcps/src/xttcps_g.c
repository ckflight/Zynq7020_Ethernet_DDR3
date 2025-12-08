#include "xttcps.h"

XTtcPs_Config XTtcPs_ConfigTable[] __attribute__ ((section (".drvcfg_sec"))) = {

	{
		"cdns,ttc", /* compatible */
		0xf8001000, /* reg */
		0x69f6bcb, /* xlnx,clock-freq */
		{0x400a}, /* interrupts */
		0xf8f01000 /* interrupt-parent */
	},
	{
		"cdns,ttc", /* compatible */
		0xf8001004, /* reg */
		0x69f6bcb, /* xlnx,clock-freq */
		{0x400b}, /* interrupts */
		0xf8f01000 /* interrupt-parent */
	},
	{
		"cdns,ttc", /* compatible */
		0xf8001008, /* reg */
		0x69f6bcb, /* xlnx,clock-freq */
		{0x400c}, /* interrupts */
		0xf8f01000 /* interrupt-parent */
	},
	 {
		 NULL
	}
};