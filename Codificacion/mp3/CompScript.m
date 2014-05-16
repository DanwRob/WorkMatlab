[input,fs] = wavread('monster.wav'); %wave file input

%set parameters. 
% comp    - compression: 0>comp>-1, expansion: 0<comp<1
% a       - filter parameter: <1, related to attack time, how quickly the filter
% responds to changes in input. Smaller numbers indicate faster response. 
comp = -0.3;
a = 0.6;

output = compexp(input, comp, a); %call compressor

sound(input,fs); %play input and output sounds
sound(output,fs);

wavwrite(output, fs, 'CompressedSnare.wav'); %save output as wave file




[input,fs] = wavread('anechoic_voice'); %wave file input

%set parameters. 
% comp    - compression: 0>comp>-1, expansion: 0<comp<1
% a       - filter parameter: <1, related to attack time, how quickly the filter
% responds to changes in input. Smaller numbers indicate faster response.
comp = -0.17;
a = 0.25;

output = compexp(input, comp, a); %call compressor

sound(input,fs); %play input and output sounds
sound(output,fs);

wavwrite(output, fs, 'CompressedVoice.wav'); %save output as wave file

