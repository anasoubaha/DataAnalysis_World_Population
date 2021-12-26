/*Creating data table */
data cas1;
    infile "/lemonde95.txt";
    input pays $ urbain religion $ espvief litterat pop_aug mortbebe region tx_nais tx_mort log_pdb nais_mor fertilit log_pop;
run;

proc print data=cas2;
run;

/*Stats depending on region variable*/
proc means data=cas2 chartype mean std min max  vardef=df maxdec=1;
    class region;
run;

/*Stats depending on region variable for the Morccain country only*/
proc means data=cas2 mean maxdec=1;
    class region;
    where pays='Maroc'
run;

/*Studying correlation between variables*/
proc corr data=cas2 pearson nosimple noprob plots=none;
    var urbain espvief litterat pop_aug mortbebe region tx_nais tx_mort log_pdb nais_mor fertilit log_pop;
run;

/*Applying PCA*/
proc princomp DATA=cas2;
run;

/*Ploting Componenent Pattern*/
ods graphics on;
ods select patternPlot;
proc princomp data=cas2 plots=pattern(vector);
    var urbain espvief litterat pop_aug mortbebe region tx_nais tx_mort log_pdb nais_mor fertilit log_pop;
run;

/*Ploting cloud of point*/

ods graphics on;
proc sgplot data=work.cas2;
    scatter x=Prin1 y=Prin2 / group=region;
    Xaxis grid;
    Yaxis grid;
run;
