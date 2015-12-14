function [ S ] = extend(X)
	S = [ones(size(X,1),1) X];
