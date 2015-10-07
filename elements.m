classdef elements
    properties
        robotObj;
        cisimObj;
        goalObj;
        groupCount;
    end
    
    methods
        
        function robotObj = get.robotObj(obj)
            robotObj = obj.robotObj;
        end
        
        function cisimObj = get.cisimObj(obj)
            cisimObj = obj.cisimObj;
        end
        
        function goalObj = get.goalObj(obj)
            goalObj = obj.goalObj;
            
        end
        
        function groupCount = get.groupCount(obj)
            groupCount = obj.groupCount;
        end
        
        
        function obj = set.robotObj(obj , robotObj)
            obj.robotObj = robotObj;
        end
        
        
        function obj = set.cisimObj(obj , cisimObj)
            obj.cisimObj = cisimObj;
        end
        
        function obj = set.goalObj(obj , goalObj)
            obj.goalObj = goalObj;
        end
        
        
        function obj = set.groupCount(obj , groupCount)
            obj.groupCount = groupCount;
        end
     
    end
end
    
