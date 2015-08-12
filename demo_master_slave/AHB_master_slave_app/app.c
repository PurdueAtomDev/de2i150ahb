#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <memory.h>

#include "PCIE.h"

//MAX BUFFER FOR DMA
#define MAXDMA 8

//BASE ADDRESS FOR CONTROL REGISTER
#define CRA 0x00000000		// This is the starting address of the Custom Slave module. This maps to the address space of the custom module in the Qsys subsystem.

//BASE ADDRESS TO SDRAM
#define SDRAM 0x08000000	// This is the starting address of the SDRAM controller. This maps to the address space of the SDRAM controller in the Qsys subsystem.
#define START_BYTE 0xF00BF00B
#define STOP_BYTE 0xDEADF00B
#define RWSIZE (32 / 8)
PCIE_BAR pcie_bars[] = { PCIE_BAR0, PCIE_BAR1 , PCIE_BAR2 , PCIE_BAR3 , PCIE_BAR4 , PCIE_BAR5 };

void test32( PCIE_HANDLE hPCIe, DWORD addr );
void testDMA( PCIE_HANDLE hPCIe, DWORD addr);

int main(void)
{
	void *lib_handle;
	PCIE_HANDLE hPCIe;
        WORD i, j;

	lib_handle = PCIE_Load();		// Dynamically Load the PCIE library
	if (!lib_handle)
	{
		printf("PCIE_Load failed\n");
		return 0;
	}
	hPCIe = PCIE_Open(0,0,0);		// Every device is a like a file in UNIX. Opens the PCIE device for reading/writing

	if (!hPCIe)
	{
		printf("PCIE_Open failed\n");
		return 0;
	}

	//test CRA
	test32(hPCIe, 8);			// Test the Configuration Registers for reads and writes

	//send start command to the user logic so that it initiates write requests to SDRAM
	PCIE_Write32( hPCIe, pcie_bars[0], 0x0, START_BYTE);

	//add some delay
        for (i=0; i<10000; i++)
          for (j=0; j<10000; j++)
	    {}

	//test SDRAM if write master functions correctly, COMMENT IT OUT if you want to use signalTap on AHB master read
	testDMA(hPCIe,SDRAM);			// Test the SDRAM for reads and writes

	//add some delay
        for (i=0; i<10000; i++)
          for (j=0; j<10000; j++)
	    {}

	//send stop command to the user logic so that it initiates read requestS to SDRAM
	PCIE_Write32( hPCIe, pcie_bars[0], 0x0, STOP_BYTE);

	printf("\nPush up SW[16] to view data stored in SDRAM and use SW[4:0] to select different addresses.\n");
	return 0;
}

//Tests 8 consecutive PCIE_Write32 to address

void test32( PCIE_HANDLE hPCIe, DWORD addr )
{
	BOOL bPass;
	DWORD testVal = 0xf000;
	DWORD readVal;

	WORD i = 0;
	for (i = 0; i < 8 ; i++ )
	{
		bPass = PCIE_Write32( hPCIe, pcie_bars[0], addr, testVal);
		if (!bPass)
		{
			printf("test FAILED: write did not return success");
			return;
		}
		bPass = PCIE_Read32( hPCIe, pcie_bars[0], addr, &readVal);
		if (!bPass)
		{
			printf("test FAILED: read did not return success");
			return;
		}
		printf("Testing register %d at addr %x with value %x: ", i, addr, testVal);

		if (testVal == readVal)
		{
			printf("Test PASSED: expected %x, received %x\n", testVal, readVal);
		}
		else
		{
			printf("Test FAILED: expected %x, received %x\n", testVal, readVal);
		}
		testVal = testVal + 1;
		addr = addr + 4;
	}
	return;
}

//tests DMA write of buffer to address
void testDMA( PCIE_HANDLE hPCIe, DWORD addr)
{
	BOOL bPass;
	DWORD testArray[MAXDMA];
	DWORD readArray[MAXDMA];
	
	WORD i = 0;
	//testArray[0] = START_BYTE;
	while ( i < MAXDMA )
	{
		testArray[i] = i  + 0xf000;
		i++;
	}

	//bPass = PCIE_DmaWrite(hPCIe, addr, testArray, MAXDMA * RWSIZE );
	//if (!bPass)
	//{
	//	printf("test FAILED: write did not return success");
	//	return;
	//}
	bPass = PCIE_DmaRead(hPCIe, addr, readArray, MAXDMA * RWSIZE );
	if (!bPass)
	{
		printf("test FAILED: read did not return success");
		return;
	}
	i = 0;
	while ( i < MAXDMA )
	{
		printf("Testing SDRAM at addr %x: ", addr);
		if (testArray[i] == readArray[i])
		{
			printf("Test PASSED: expected %x, received %x\n", testArray[i], readArray[i]);
		}
		else
		{
			printf("Test FAILED: expected %x, received %x\n", testArray[i], readArray[i]);
		}
		i++;
		addr = addr + 4;
	}
	return;
}
