aws cloudformation create-stack \
	--stack-name $2 --template-body\
	file:///$PWD/$1
