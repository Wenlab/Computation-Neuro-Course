clear all;
tic


thresh=1; % neurons' thresholds - now all are set to the same value
tau=1*1e-2;  % membrane time constant sec
Ic=thresh;   % baseline applied current

%% ** DECLARE your new constants here
%% try out the values presented in teh problem set, along with ones you
%% choose yourself...

dt=1e-4; % size of timestep in sec
dtau=dt/tau;

Ttot=1;  % total time in secs;
T=ceil(Ttot/dt);  % number of timesteps
dI=0.01*Ic;
N_isi=2;
II=Ic+[0.001:0.001:0.01,0.01:0.01:1];   % vector of injected currents, increasing from 1
N=length(II);                           % N number of individual I-F neurons being simulated, each having a single current injected.
spiketimes=cell(1,N);                   % cell array for each neuron's spiketimes
rate=zeros(1,N);
V=zeros(1,N);
ispikes=zeros(1,N);                     % Total # of spikes in past history
u=zeros(2,T);

for k=2:T
    u(:,k)=V([1 N])';       % u is the voltage trace of 2 neurons - one receiving minimum current, another receiving maximum current.
    %% **insert your code for updating Ia by Euler integration here.
    %% **you will need to initialize any new variables you create, as was
    %% **done to integrate V below;  HINT: you will also need to add more code to
    %% **integrate properly when the neuron crosses threshhold, and also
    %% **obviously include Ia in the equation for updating V
    
    V=(1-dtau)*V+dtau*II;   % regular Euler integration
    cross=(V>=thresh);   	% here we test for threshold crossing
    ind=find(cross);
    if length(ind)>0      % If there exist neurons that crossed threshold voltage, (here we update the neurons that crossed threshold)
        V(ind)=0;           % Set the neuron's voltage to 0
        for l=ind                                               % for all the neurons crossed threshold
            spiketimes{l}=[spiketimes{l};dt*k];                 % Keep record of spike timing
            ispikes(l)=ispikes(l)+1;                            % Update total number of spikes
        end
    end
end



for k=1:N
    if length(spiketimes{k})>0            % if neuron k has at least 1 spike
        a=spiketimes{k}';                   % (in secs)
        rate(k)=length(a)/Ttot;             % average firing rate 
        isi=diff(a);                        % Inter-Spike-Interval
        nn=length(isi);
        if nn>=N_isi
            frate(k,1:N_isi)=1./isi(1:N_isi); % instantaneous firing rate 
        end
    end
end

figure
plot(II,rate,'b',II,frate(:,1),'r')
xlabel('injected current (normalized)');
ylabel('firing rate (Hz)');
legend('average rate','1/ISI');
title('f-I curves for non-adapting neuron');
set(gca,'xlim',[0.9 2]);

tt=dt:dt:Ttot;
figure
subplot(2,1,1);
plot(tt,u(1,:)) 	% u(1,:) shows low firing rate due to small current injection
ylabel('voltage (normalized)');
title('Traces of two neurons');
subplot(2,1,2);
plot(tt,u(2,:)) 	% u(2,:) shows high firing rate due to large current injection
xlabel('time (seconds)');
ylabel('voltage (normalized)');

simtime=toc

