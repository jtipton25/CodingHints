# Emacs hints and commands

## C- means Control- and M- means Meta-(Option Key) 

### Resetting the meta key on Mac OS from Esc to Option in Terminal


Terminal Dropdown -> Preferences -> Settings -> Keyboard -> check 'use option as meta' 

C-g <- abort command


### Opening, saving, and closing files

emacs filename		<- Open filename from terminal in an emacs editor

C-x C-s			      <- Save a File

C-x C-c			      <- Save and quit 

C-x C-w			      <- Save as a new file

C-x C-f			      <- Find a file

## Switch between buffers
C-x arrow

C-x b

## List open buffers
C-x C-b

## Basic Text editing 

M-d			## Delete a word

C-k			## Delete a line and copy (kill)

C-y			## Put deleted line in document - paste (yank)

C-_			## Undo

M-% (shift key)		## Find - replace 

M-y 	   		## cycle to next item in kill ring (how cool is the term 'kill ring'?!)

C-x r k 		## rectangular kill

C-x-r y  		## rectangular yank (rectangular kill ring can only have one item, so be careful)

M-q  			## auto fill

## Moving through the document

C-f			## Move forward one character

C-b			## Move backward one character

C-n			## Move down a line

C-p			## Move up a line

C-a			## Move to the beginning of the line

C-e 			## Move to the end of a line

C-v			## Move down a page

M-v			## Move up a page

C-l			## Recenter the cursor in the center of the page

## Advanced commands
	
M-! (shift)		## Terminal command

C-x 1			## reduce screen to one window

C-x 2			## split the screen horizontally

C-x 3			## split the screen verticall

C-x o (not zero)	## switch between windows

C-x b			## change buffers

C-c C-c  		## compile .tex document

## Mathematics equations

\begin{align*}

y_j \stackrel{iid} {\sim} N( 0, \sigma^2 )

\end{align*}

$$
\begin{align*}
y_j \stackrel{iid} {\sim} N(0, {\sigma^2})
\end{align*}
$$

\begin{align*}

\begin{array}{cc} \bm{\Sigma}_{It} & \bm{0}\\ \bm{0} & \bm{\Sigma}_{Pt} \end{array}

\end{align*}

$$
\begin{align*}
\begin{array}{cc} \boldmath{\Sigma}_{It} & \boldmath{0}\\ \boldmath{0} & \boldmath{\Sigma}_{Pt} \end{array}
\end{align*}
$$


\left[ \beta_j \middle| \sigma^2, \lambda_j, \gamma_j \right] & \stackrel{iid} {\sim} \begin{cases} 0 & \mbox{if } \gamma_j = 0\\ \mbox{N}\left( 0, \frac{\sigma^2} {\lambda_j} \right) & \mbox{if } \gamma_j = 1 \end{cases}


$$
\begin{align*}
\left[ \beta_j \middle| \sigma^2, \lambda_j, \gamma_j \right] & \stackrel{iid} {\sim} \begin{cases} 0 & \mbox{if } \gamma_j = 0\\ \mbox{N}\left( 0, \frac{\sigma^2} {\lambda_j} \right) & \mbox{if } \gamma_j = 1 \end{cases}
\end{align*}
$$
