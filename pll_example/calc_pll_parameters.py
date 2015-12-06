
f_input = 12000000

f_target = input("\nType the desired output frequency (i.e. 44100). Value in Hz: ")

parameters = []

DIVR_vals = range(1,17)
DIVF_vals = range(1,129)

PRESCALER_N_vals = range(0,32)


for DIVR in DIVR_vals:
    for DIVF in DIVF_vals:
        for PRESCALER_N in PRESCALER_N_vals:
            f_pllout = f_input*float(DIVF)/float(DIVR)
            if f_pllout > 16e6 and f_pllout < 275e6:
                fout = f_pllout/float(2**PRESCALER_N)
                error = abs(f_target-fout)
                parameters.append([error,fout,(DIVR,DIVF,PRESCALER_N)])


parameters.sort()


print("\nNow program the PLL with one of the following sets of parameters:")

for i in xrange(5):
    [error,fout,(DIVR,DIVF,PRESCALER_N)] = parameters[i]
    DIVR_str = '{0:04b}'.format(DIVR-1)
    DIVF_str = '{0:07b}'.format(DIVF-1)
    print("   "+str(i+1)+") DIVR="+DIVR_str+"  DIVF="+DIVF_str+"  PRESCALER_N="+str(PRESCALER_N)+"  Fout="+str(fout)+"Hz (error="+str(error)+"Hz)")

