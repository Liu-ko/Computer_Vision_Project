classdef train_model_GUI < matlab.apps.AppBase

    % Properties that correspond to app components
    properties (Access = public)
        TrainModel                    matlab.ui.Figure
        LoadManmadeTrainingSetButton  matlab.ui.control.Button
        LoadNaturalTrainingSetButton  matlab.ui.control.Button
        TrainKNNClassifierButton      matlab.ui.control.Button
        NumberofNeighboursEditFieldLabel  matlab.ui.control.Label
        NumberofNeighboursEditField   matlab.ui.control.NumericEditField
        LoadManmadeTestSetButton      matlab.ui.control.Button
        DistanceDropDownLabel         matlab.ui.control.Label
        DistanceDropDown              matlab.ui.control.DropDown
        ErrorMessage                  matlab.ui.control.Label
        LoadNaturalTestSetButton      matlab.ui.control.Button
        ClassifyImageButton           matlab.ui.control.Button
    end

    
    properties (Access = public)
        mTestSet;
        mTestSetLoaded = false;
        
        nTestSet;
        nTestSetLoaded = false;
        
        numNeighbours = 20;
        distance = 'cosine';
        
        imageWidth = 180; % width of the image
        imageHeight = 180; % height of the image
        
        manmadeImageSet % manmade training set
        manmadeImageSetLoaded = false; % stores whether or not a image set has been loaded
        
        naturalImageSet % natural training set
        naturalImageSetLoaded = false; % stores whether or not a image set has been loaded
        
        canTrain = false;
    end
    
    methods (Access = public)
        function ValidateInputs(app)
            if app.numNeighbours <= 0
                app.canTrain = false;
                app.ErrorMessage.FontColor = [1 0 0];
                app.ErrorMessage.Text = sprintf('The number of neighbours \nmust be larger than 0');
            elseif app.imageHeight <= 0 || app.imageWidth <= 0
                app.canTrain = false;
                app.ErrorMessage.FontColor = [1 0 0];
                app.ErrorMessage.Text = sprintf('Image resolution must be \nlarger than 0.\nThe recommended size is 180.');
            elseif (app.manmadeImageSetLoaded == false)
                app.canTrain = false;
                app.ErrorMessage.FontColor = [1 0 0];
                app.ErrorMessage.Text = sprintf('Please load the manmade \ntraining set');
            elseif (app.naturalImageSetLoaded == false)
                app.canTrain = false;
                app.ErrorMessage.FontColor = [1 0 0];
                app.ErrorMessage.Text = sprintf('Please load the natural \ntraining set');
            elseif (app.mTestSetLoaded == false)
                app.canTrain = false;
                app.ErrorMessage.FontColor = [1 0 0];
                app.ErrorMessage.Text = sprintf('Please load the manmade \ntest set');
            elseif (app.nTestSetLoaded == false)
                app.canTrain = false;
                app.ErrorMessage.FontColor = [1 0 0];
                app.ErrorMessage.Text = sprintf('Please load the natural \ntest set');
            else
                app.canTrain = true;
                app.ErrorMessage.FontColor = [0 0 0];
                app.ErrorMessage.Text = "Ready to train model";
            end
        end
    end
    

    methods (Access = private)

        % Button pushed function: LoadManmadeTrainingSetButton
        function LoadManmadeTrainingSetButtonPushed(app, event)
            app.manmadeImageSetLoaded = false;
            ValidateInputs(app);
            imgSetPath = uigetdir+"\";
            app.manmadeImageSet = filesRead(imgSetPath);
            if(isempty(app.manmadeImageSet))
                app.manmadeImageSetLoaded = false;
            else
                app.manmadeImageSetLoaded = true;
            end
            ValidateInputs(app)
        end

        % Button pushed function: LoadNaturalTrainingSetButton
        function LoadNaturalTrainingSetButtonPushed(app, event)
            app.naturalImageSetLoaded = false;
            ValidateInputs(app);
            imgSetPath = uigetdir+"\";
            app.naturalImageSet = filesRead(imgSetPath);
            if(isempty(app.naturalImageSet))
                app.naturalImageSetLoaded = false;
            else
                app.naturalImageSetLoaded = true;
            end
            ValidateInputs(app);
        end

        % Button pushed function: LoadManmadeTestSetButton
        function LoadManmadeTestSetButtonPushed(app, event)
            app.mTestSetLoaded = false;
            ValidateInputs(app);
            imgSetPath = uigetdir+"\";
            app.mTestSet = filesRead(imgSetPath);
            if(isempty(app.mTestSet))
                app.mTestSetLoaded = false;
            else
                app.mTestSetLoaded = true;
            end
            ValidateInputs(app);
        end

        % Value changed function: DistanceDropDown
        function DistanceDropDownValueChanged(app, event)
            app.distance = app.DistanceDropDown.Value;
        end

        % Callback function
        function ImageWidthEditFieldValueChanged(app, event)
            app.imageWidth = app.ImageWidthEditField.Value;
            ValidateInputs(app);
        end

        % Callback function
        function ImageHeightEditFieldValueChanged(app, event)
            app.imageHeight = app.ImageHeightEditField.Value;
            ValidateInputs(app);
        end

        % Button pushed function: TrainKNNClassifierButton
        function TrainKNNClassifierButtonPushed(app, event)
            if (app.canTrain == true)
                % get path to save model to
               [file, path] = uiputfile('.mat');
               savePath = fullfile(path, file);
               
               ml_train(app.imageWidth, app.imageHeight, app.numNeighbours, app.distance, app.manmadeImageSet, app.naturalImageSet, app.mTestSet, app.nTestSet, savePath);
            end
        end

        % Button pushed function: LoadNaturalTestSetButton
        function LoadNaturalTestSetButtonPushed(app, event)
            app.nTestSetLoaded = false;
            ValidateInputs(app);
            imgSetPath = uigetdir+"\";
            app.nTestSet = filesRead(imgSetPath);
            if(isempty(app.nTestSet))
                app.nTestSetLoaded = false;
            else
                app.nTestSetLoaded = true;
            end
            ValidateInputs(app);
        end

        % Value changed function: NumberofNeighboursEditField
        function NumberofNeighboursEditFieldValueChanged(app, event)
            app.numNeighbours = app.NumberofNeighboursEditField.Value;
            ValidateInputs(app);
        end

        % Button pushed function: ClassifyImageButton
        function ClassifyImageButtonPushed(app, event)
            [file, path] = uigetfile('', 'Load model object');
            model = loadCompactModel(fullfile(path, file));
            
            [file, path] = uigetfile('', 'Choose image to classify');
            img = imread(fullfile(path, file));
            
            if(isempty(img))
                msgbox('Failed to load image');
            else
                img = imresize(img, [180 180]);
                i{1} = img;
                t = getAllFeatures(i);
                label = predict(model, t);
                
                if (label == 1)
                    msgbox('This image has been classified as manmade');
                elseif (label == 0)
                    msgbox('This image has been classified as natural');
                else
                    msgbox('Something went horribly wrong');
                end
            end
        end
    end

    % App initialization and construction
    methods (Access = private)

        % Create UIFigure and components
        function createComponents(app)

            % Create TrainModel
            app.TrainModel = uifigure;
            app.TrainModel.Position = [100 100 194 323];
            app.TrainModel.Name = 'Train KNN Model';

            % Create LoadManmadeTrainingSetButton
            app.LoadManmadeTrainingSetButton = uibutton(app.TrainModel, 'push');
            app.LoadManmadeTrainingSetButton.ButtonPushedFcn = createCallbackFcn(app, @LoadManmadeTrainingSetButtonPushed, true);
            app.LoadManmadeTrainingSetButton.Position = [13 287 171 22];
            app.LoadManmadeTrainingSetButton.Text = 'Load Manmade Training Set';

            % Create LoadNaturalTrainingSetButton
            app.LoadNaturalTrainingSetButton = uibutton(app.TrainModel, 'push');
            app.LoadNaturalTrainingSetButton.ButtonPushedFcn = createCallbackFcn(app, @LoadNaturalTrainingSetButtonPushed, true);
            app.LoadNaturalTrainingSetButton.Position = [13 255 171 22];
            app.LoadNaturalTrainingSetButton.Text = 'Load Natural Training Set';

            % Create TrainKNNClassifierButton
            app.TrainKNNClassifierButton = uibutton(app.TrainModel, 'push');
            app.TrainKNNClassifierButton.ButtonPushedFcn = createCallbackFcn(app, @TrainKNNClassifierButtonPushed, true);
            app.TrainKNNClassifierButton.Position = [12 41 171 22];
            app.TrainKNNClassifierButton.Text = 'Train KNN Classifier';

            % Create NumberofNeighboursEditFieldLabel
            app.NumberofNeighboursEditFieldLabel = uilabel(app.TrainModel);
            app.NumberofNeighboursEditFieldLabel.HorizontalAlignment = 'right';
            app.NumberofNeighboursEditFieldLabel.Position = [13 158 126 22];
            app.NumberofNeighboursEditFieldLabel.Text = 'Number of Neighbours';

            % Create NumberofNeighboursEditField
            app.NumberofNeighboursEditField = uieditfield(app.TrainModel, 'numeric');
            app.NumberofNeighboursEditField.ValueChangedFcn = createCallbackFcn(app, @NumberofNeighboursEditFieldValueChanged, true);
            app.NumberofNeighboursEditField.Position = [147 158 37 22];
            app.NumberofNeighboursEditField.Value = 20;

            % Create LoadManmadeTestSetButton
            app.LoadManmadeTestSetButton = uibutton(app.TrainModel, 'push');
            app.LoadManmadeTestSetButton.ButtonPushedFcn = createCallbackFcn(app, @LoadManmadeTestSetButtonPushed, true);
            app.LoadManmadeTestSetButton.Position = [13 223 171 22];
            app.LoadManmadeTestSetButton.Text = 'Load Manmade Test Set';

            % Create DistanceDropDownLabel
            app.DistanceDropDownLabel = uilabel(app.TrainModel);
            app.DistanceDropDownLabel.HorizontalAlignment = 'right';
            app.DistanceDropDownLabel.Position = [13 126 52 22];
            app.DistanceDropDownLabel.Text = 'Distance';

            % Create DistanceDropDown
            app.DistanceDropDown = uidropdown(app.TrainModel);
            app.DistanceDropDown.Items = {'cityblock', 'chebychev', 'correlation', 'cosine', 'euclidean', 'hamming', 'jaccard', 'mahalanobis', 'minkowski', 'seuclidean', 'spearman'};
            app.DistanceDropDown.ValueChangedFcn = createCallbackFcn(app, @DistanceDropDownValueChanged, true);
            app.DistanceDropDown.Position = [82 126 102 22];
            app.DistanceDropDown.Value = 'cosine';

            % Create ErrorMessage
            app.ErrorMessage = uilabel(app.TrainModel);
            app.ErrorMessage.VerticalAlignment = 'top';
            app.ErrorMessage.FontColor = [1 0 0];
            app.ErrorMessage.Position = [13 75 170 40];
            app.ErrorMessage.Text = '';

            % Create LoadNaturalTestSetButton
            app.LoadNaturalTestSetButton = uibutton(app.TrainModel, 'push');
            app.LoadNaturalTestSetButton.ButtonPushedFcn = createCallbackFcn(app, @LoadNaturalTestSetButtonPushed, true);
            app.LoadNaturalTestSetButton.Position = [13 191 171 22];
            app.LoadNaturalTestSetButton.Text = 'Load Natural Test Set';

            % Create ClassifyImageButton
            app.ClassifyImageButton = uibutton(app.TrainModel, 'push');
            app.ClassifyImageButton.ButtonPushedFcn = createCallbackFcn(app, @ClassifyImageButtonPushed, true);
            app.ClassifyImageButton.Position = [13 12 170 22];
            app.ClassifyImageButton.Text = 'Classify Image';
        end
    end

    methods (Access = public)

        % Construct app
        function app = train_model_GUI

            % Create and configure components
            createComponents(app)

            % Register the app with App Designer
            registerApp(app, app.TrainModel)

            if nargout == 0
                clear app
            end
        end

        % Code that executes before app deletion
        function delete(app)

            % Delete UIFigure when app is deleted
            delete(app.TrainModel)
        end
    end
end