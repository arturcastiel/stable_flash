classdef SystemState < handle
    %SystemState Class that Encapsulate the State of a System
    properties
        T
        P
    end  
    methods
        function obj = SystemState(Pvec,Tvec)
            %SystemState Construct an instance of this class
            obj.P = Pvec;
            obj.T = Tvec;
        end
    end
end

