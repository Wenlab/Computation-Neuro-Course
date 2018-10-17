M = 7000;
N = 21000;
clear Combinations;
figure;
hold on;
for K=1:1:3
	Combinations(K)=nchoosek(M,K);
	if Combinations(K)>= N
		temp = log((Combinations(K)-N+1):Combinations(K));
		log_p = sum(temp) - N*temp(N);
		p(K) = exp(log_p);
	else
		p(K) = 0;
	end
end
plot(1:1:length(p),p,'o-');
hold off;

M = 20;
N = 20;
clear Combinations;
figure;
hold on;
for K=1:1:M-1
	Combinations(K)=nchoosek(M,K);
	if Combinations(K)>= N
		temp = log((Combinations(K)-N+1):Combinations(K));
		log_p = sum(temp) - N*temp(N);
		p(K) = exp(log_p);
	else
		p(K) = 0;
	end
end
plot(1:1:length(p),p,'o-');
hold off;