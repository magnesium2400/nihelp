classdef finiteDifference_test < matlab.unittest.TestCase
    methods (Test)
        function testDefaultX(testCase)
            y = [1 4 9 16];
            expected = [4 6];
            actual = finiteDifference(y);
            testCase.verifyEqual(actual, expected);
        end

        function testExplicitX(testCase)
            x = [1 2 3 4];
            y = [1 4 9 16];
            expected = [4 6];
            actual = finiteDifference(x, y);
            testCase.verifyEqual(actual, expected);
        end

        function testCentralWithEndpoints(testCase)
            x = 1:4;
            y = x.^2;
            actual = finiteDifference(x, y, 'method', 'central', 'includeEndpoints', true);
            expected = [3 4 6 7]; % approx central differences
            testCase.verifyEqual(actual, expected, 'AbsTol', 1e-10);
        end

        function testForwardWithEndpoints(testCase)
            x = 1:4;
            y = x.^2;
            actual = finiteDifference(x, y, 'method', 'forward', 'includeEndpoints', true);
            expected = [3 5 7 7];
            testCase.verifyEqual(actual, expected);
        end

        function testBackwardWithEndpoints(testCase)
            x = 1:4;
            y = x.^2;
            actual = finiteDifference(x, y, 'method', 'backward', 'includeEndpoints', true);
            expected = [3 3 5 7];
            testCase.verifyEqual(actual, expected);
        end

        function testAlongDifferentDim(testCase)
            y = [1 4 9 16]';
            expected = [4 6]';
            actual = finiteDifference([], y, 1);
            testCase.verifyEqual(actual, expected);
        end

        function testMatrixInputDim2(testCase)
            y = [1 4 9 16; 1 8 27 64];
            dim = 2;
            actual = finiteDifference([], y, dim);
            expected = [4 6; 13 28];
            testCase.verifyEqual(actual, expected);
        end

        function testAutoDimDetection(testCase)
            x = 1:4;
            y = (x.^2)';
            expected = [4;6];
            actual = finiteDifference(x, y);
            testCase.verifyEqual(actual, expected);
        end

        function testMismatchedLengthError(testCase)
            x = [1 2 3];
            y = [1 4];
            testCase.verifyError(@() finiteDifference(x, y), 'MATLAB:assertion:failed');
        end

        function testIncludeEndpointsFalse(testCase)
            x = [1 2 3 4];
            y = [1 4 9 16];
            actual = finiteDifference(x, y, 'method', 'central', 'includeEndpoints', false);
            expected = [4 6];
            testCase.verifyEqual(actual, expected);
        end
    end
end
