#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <memory.h>

#include "PCIE.h"

//MAX BUFFER FOR DMA
#define MAXDMA 8

//BASE ADDRESS FOR CONTROL REGISTER

#define CRA 0x00000000		// This is the starting address of the AHB slave IP. This maps to the address space of the top level module in the Qsys subsystem.

#define RWSIZE (32 / 8)
PCIE_BAR pcie_bars[] = { PCIE_BAR0, PCIE_BAR1 , PCIE_BAR2 , PCIE_BAR3 , PCIE_BAR4 , PCIE_BAR5 };

void test32( PCIE_HANDLE hPCIe, DWORD addr );

int main(void)
{
	void *lib_handle;
	PCIE_HANDLE hPCIe;
	BOOL bPass;

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
 
	//write shift value 1 to AHB slave register[2]
	bPass = PCIE_Write32( hPCIe, pcie_bars[0], 0x8, 1 );
	if (!bPass)
	  {
	    printf("writing shift value to reg[2] failed");
	    return 0;
	  }

	//write shift value 1 to AHB slave register[3]
	bPass = PCIE_Write32( hPCIe, pcie_bars[0], 0xC, 1 );
	if (!bPass)
	  {
	    printf("writing shift value to reg[3] failed");
	    return 0;
	  }

	//test if AHB slave interface as well as user module is functioning correctly
	test32(hPCIe, CRA);	    

	printf("finished");
	return 0;
}



void test32( PCIE_HANDLE hPCIe, DWORD addr )
{
	BOOL bPass;
	DWORD testVal = 0x0000;
	DWORD readVal, expVal, testdata;

        //write a shift right command to the buffer write
        bPass = PCIE_Write32( hPCIe, pcie_bars[0], addr, 0x10000000);
	if (!bPass)
	  {
	    printf("shift right command failed");
	    return;
	  }
	WORD i = 0;
        //sends a stream of 8 data to be processed to the buffer write
	for (i = 0; i < 8 ; i++ )
	{
	  testdata = testVal + 0x80000000;  //note here each data is encoded: 0x80000000 stands for data to the user logic
	  bPass = PCIE_Write32( hPCIe, pcie_bars[0], addr, testdata);
	  if (!bPass)
	    {
	      printf("test FAILED: write did not return success");
	      return;
	    }
	  testVal = testVal + 0x1111;
	}

	testVal = 0x0000;
        //write a shift left command to the buffer write
        bPass = PCIE_Write32( hPCIe, pcie_bars[0], addr, 0x20000000);
	if (!bPass)
	  {
	    printf("shift left command failed");
	    return;
	  }

        //sends a stream of 8 data to be processed to the buffer write
	for (i = 0; i < 8 ; i++ )
	{
	  testdata = testVal + 0x80000000;
	  bPass = PCIE_Write32( hPCIe, pcie_bars[0], addr, testdata);
	  if (!bPass)
	    {
	      printf("test FAILED: write did not return success");
	      return;
	    }
	  testVal = testVal + 0x1111;
	}

        //write an end command to the buffer write
        bPass = PCIE_Write32( hPCIe, pcie_bars[0], addr, 0x40000000);
	if (!bPass)
	  {
	    printf("end command failed");
	    return;
	  }
        
        testVal = 0x0000;
        expVal = 0x0000 >> 1;
        //read back data from read buffer and check correctness
	for (i = 0; i < 8 ; i++ )
	{
		bPass = PCIE_Read32( hPCIe, pcie_bars[0], 0x4, &readVal);
		if (!bPass)
		{
			printf("test FAILED: read did not return success");
			return;
		}
		printf("Testing buffer read %d at addr %x with value %x shifted right: ", i, 0x04, testVal);

		if (readVal == expVal)
		{
			printf("Test PASSED: received %x\n", readVal);
		}
		else
		{
			printf("Test FAILED: received %x\n", readVal);
		}
                testVal = testVal + 0x1111;
		expVal = testVal >> 1;
	}

        testVal = 0x0000;
        expVal = 0x0000 << 1;
	for (i = 0; i < 8 ; i++ )
	{
		bPass = PCIE_Read32( hPCIe, pcie_bars[0], 0x4, &readVal);
		if (!bPass)
		{
			printf("test FAILED: read did not return success");
			return;
		}
		printf("Testing buffer read %d at addr %x with value %x shifted left: ", i+8, 0x04, testVal);

		if (readVal == expVal)
		{
			printf("Test PASSED: received %x\n", readVal);
		}
		else
		{
			printf("Test FAILED: received %x\n", readVal);
		}
                testVal = testVal + 0x1111;
		expVal = testVal << 1;
	}

	//check for processing done signal sent from the user logic
	bPass = PCIE_Read32( hPCIe, pcie_bars[0], 0x10, &readVal);
	if (!bPass)
	  {
	    printf("test FAILED: read did not return success");
	    return;
	  }
	printf("checking processing done signal, ");

	if (readVal == 0xFFFF)
	  {
	    printf("Test PASSED\n");
	  }
	else
	  {
	    printf("Test FAILED\n");
	  }
	return;
}
