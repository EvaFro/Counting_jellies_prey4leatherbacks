%% Jelly_Counting_code.m %%
% This code was a product of Erin's 2010-2014 jellyfish project @ CSU 
% Monterey Bay and Montana State Univieristy. 


%% Author Information %%

% * Author: E.Frolli
% * Orginization: Univeristy of Texas Marine Science Institute
% * Contact: frolli.erin@utexas.edu
% * Date: 2010-2014

%% Code %%
% The code was designed to automate counting of individual
% jellies from Aerial photographs taken from the belly window of a
% twin-engine fix wing aircraft. All transects were conducted using three 
% person observer team in a twin engine fix wing following methods 
% described in Forney et al. 1991 and Benson et al. 2007. The height of 
% the plane during transects was 198m with a speed of 90-100 knots as 
% previously described in Forney et al. 1991 and Benson et al. 2007. 
 
% For this code to work the photograph must be in a format that allows
% Matlab to surch through the digital RGB values of each pixel. Before this
% program is run you must also have the average surface area in pixels of
% each species for the last section of the code.
 
% NOTE: Use the correct species surface area and SD. If you change it up
% here, make sure you also change it in the last section of this code to
% make sure your data is labled properly. To switch, simply delete the
% note sign (%) from the infront of the the line of code for the speices 
% of interest and add it to the the note sign to the front of the other 
% speices.


% CF_a = 324.89; %Average surface area of Crysora
% CF_sd = 193.51; %SD for area of Crysora


AS_a = 152.19; %Average surface area of moons
AS_sd = 74.52; %SD for area of moons
 
I=imread('IMG_0019.JPG'); %Loads the photo for use as a matrix. Note that 

%% Choosing Random Jellies for Pixel Data

%In the next section, the photo will be spilt into 1/4ths. Each section
%will be croped and desplayed with a random red dot. Choose the closest
%jelly to the random red dot. Zoom completely in on the individual jelly
%closest to the red dot, so that you may select the approprate pixel. Once
%the image is zoomed in, use the top tab choose the data courser tool. This
%can be accessed by going to Tools > Data Courser.
%This tool will turn the courser into a t-shape. This function will now
%allow you to find, X,Y coordinates of the individual jelly. For the imcrop
%function in the section below you will want the top-left most corner of
%the jelly with the brightest jelly color. Write this X,Y coordinate in the
%appropriate code below. 

%Note the code is paused between each jelly selection. Once you have
%selected the appropriate X,Y coordint press any key into the main diolog
%box to continue to the next image. 



CC1=imcrop(I,[1 1 1944 1296]); %crops the first quorter of the image
p=round(10000*rand(2,100)); %creates a random number matrix
imshow(CC1) %plots the cropped image
hold on, %attaches the plot
plot(p(1,:),p(2,:),'yo') %plots random red circles
hold off %resets the hold state to default behavior
pause %press any key into the main diolog box to continue

CC2=imcrop(I,[1 1296 1944 2592]); % Crops second area of interest
p=round(10000*rand(2,100)); %creates a new random number matrix
imshow(CC2) %plots the cropped image
hold on, %attaches the plot
plot(p(1,:),p(2,:),'yo') %plots random red circles
hold off %resets the hold state to default behavior
pause %press any key into the main diolog box to continue

CC3=imcrop(I,[1944 1 1944 1296]); % Crops third area of interest
p=round(10000*rand(2,100)); %creates a new random number matrix
imshow(CC3) %plots the cropped image 
hold on, %attaches the plot
plot(p(1,:),p(2,:),'yo') %plots random red circles
hold off %resets the hold state to default behavior
pause %press any key into the main diolog box to continue


CC4=imcrop(I,[1944 1296 3888 2592]);
p=round(10000*rand(2,100)); %creates a new random number matrix
imshow(CC4)%plots the cropped image
hold on, %attaches the plot
plot(p(1,:),p(2,:),'yo') %plots random red circles
hold off %resets the hold state to default behavior
pause %press any key into the main diolog box to continue



%% Collecting Pixel Color Data
 
%This section corps the photo around the four indiviudal jellies that yuo
%have chosen as your representatives of the photo.

%The imcrop function crops the original image (in this case I). The first
%two values of the matrix are the X,Y coordinates of the jelly from the
%section above. The second two numbers are the surface area of the jelly
%that you would like to use for colecting pixel color ranges. For example,
%(I[120 825 3 3]) says that you would like to crop image I into a 3x3
%matrix starting at the top left courner (120, 825). 

C1=imcrop(I,[807 568 6 6]); % Crops first area of interest
C2=imcrop(I,[1317 753 6 6]); % Crops second area of interest
C3=imcrop(I,[1417 305 6 6]); % Crops third area of interest
C4=imcrop(I,[790 864 6 6]);% Crops fourth area of interest



RGB_Values = [C1 % Vector of RGB values
    C2
    C3
    C4];
 
M_=max(RGB_Values);
MAX = max(M_);% Finds the OVERALL Max values of the RGB Values 
M__=min(RGB_Values);
MIN = min(M__);% Finds the OVERALL Min values of the RGB Values
MAXr=MAX(1,1,1); % names the Max red value 
MAXg=MAX(1,1,2); % names the Max green value
MAXb=MAX(1,1,3); % names the Max blue value
MINr=MIN(1,1,1); % names the Min red value
MINg=MIN(1,1,2); % names the Min green value
MINb=MIN(1,1,3); % names the Min blue value

%% Exporting RGB Values

%You can export the RGB values into an excel document by the following
%code. Note name the document the same as the image with density catagory
%and species type (i.e. IMG_0019_High_Moons.xls). 

%writetable(RGB_Values,'IMG_0019_High_Moons.csv');

%% Pixel Finder Algorithm

%In this section we will be finding the overal numbner of pixels contianed
%in the photo that are in our specified maximum and minimum RGB Values.

%We first need to define the size of the photo, named [Y X Color].

[Y X color]=size(I); 

%Then creat an empty vector to store our overall number of pixels found by
%the algorithm.
count=[0]; % Starts the pixel count at 0

% We are going to use a double For-End lope that has an IF statement for
% each RGB color. This tells MatLab to start at the top-left corner of the
% photo matrix and move from pixel to pixel looking for the defined RGB
% requirements. 
 
% NOTE: That the last column of the photograph is data storage of the 
% photographs properties not color data. 
 
% We are using the maximum and minimum values to define the IF statements
% for each RGB values. Value codes below.
% 1 = r = red
% 2 = g = green
% 3 = b = blue
 
% Once a pixel is found it is tagged using the brightest red value 
% (225 = Bright Red). This is done so that the technician can double check
% that the code was finding the correct values when searching through the
% photograph.
 

 
for y = 1:Y-1; % tells the code to start at the first pixel in the top-left
%  and go through the whole photo until the last row 
 
for x = 1:X-1; % tells the code to start at the first pixel and go 
% through the whole photo 
 
if(I(y,x,1)>= MINr)&&(I(y,x,1)<= MAXr)... %searches for red values
&&(I(y,x,2)>= MINg)&&(I(y,x,2)<= MAXg)... %seaches for green values
&&(I(y,x,3)>= MINb)&&(I(y,x,3)<= MAXb);  %searches for blue values
 
I(y,x,1)=225; % highlight all pixels that match the correct criteria 
 
count=count+1; % includes this pixel to the count
end% ends first loop
end% ends second loop
end% ends third loop
 
imshow(I)
%% Species Counter
 
% Final Number of jellies estimated by the algorithm comes from the number 
% of pixels tagged in the photograph (count vector number) divided by the 
% average surface area (in pixels) of the species of interest. 
 
% The format long function is used to expand your number of interest out to
% 15 decimal places for a more accurate number

format short
% No_Jellies = count./Average_Jelly_Surface_Area

% CF_n = count./CF_a % Average No. of Crysora
% CF_n1 = count./(CF_a - CF_sd) % Min No. of Crysora
% CF_n2 = count./(CF_a + CF_sd) % Max No. of Crysora

AS_n = count./AS_a %Average No. of Moons
AS_n2 = count./(AS_a + AS_sd) %Min No. of Moons largest area
AS_n1 = count./(AS_a - AS_sd) %Max No. of Moons smallest area
