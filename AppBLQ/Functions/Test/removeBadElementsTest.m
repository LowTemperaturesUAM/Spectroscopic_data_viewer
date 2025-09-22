function tests =removeBadElementsTest
tests = functiontests(localfunctions);
end


function testRows(testCase)
inputMatrix = ones(128,64);
badLine = 56;
badMatrix = inputMatrix;
badMatrix(badLine,:) = 0;
fixedMatrix = removeBadLine(badMatrix,badLine,axis="rows");
verifyEqual(testCase,inputMatrix,fixedMatrix)
end

function testCols(testCase)
inputMatrix = ones(128,64);
badLine = 56;
badMatrix = inputMatrix;
badMatrix(:,badLine) = 0;
fixedMatrix = removeBadLine(badMatrix,badLine,axis="columns");
verifyEqual(testCase,inputMatrix,fixedMatrix)
end

function testPoints(testCase)
inputMatrix = ones(128,64);
badMatrix = inputMatrix;
badRow = 18;
badCol = 33;
badMatrix(badRow,badCol) = 20;
mask = zeros(128,64,'logical');
mask(badRow,badCol) = true;
fixedMatrix = removeBadPoints(badMatrix,mask);
verifyEqual(testCase,inputMatrix,fixedMatrix);
end