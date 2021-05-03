classdef FUF_App < matlab.apps.AppBase

    % Properties that correspond to app components
    properties (Access = public)
        UIFigure                     matlab.ui.Figure
        TabGroup                     matlab.ui.container.TabGroup
        LampToggleTab                matlab.ui.container.Tab
        ToggleLampButton             matlab.ui.control.StateButton
        OffLabel                     matlab.ui.control.Label
        LampStatusLabel              matlab.ui.control.Label
        MultiplyTab                  matlab.ui.container.Tab
        AnswerLabel                  matlab.ui.control.Label
        FindProductButton            matlab.ui.control.Button
        SecondDigitEditField         matlab.ui.control.NumericEditField
        SecondDigitEditFieldLabel    matlab.ui.control.Label
        FirstDigitEditField          matlab.ui.control.NumericEditField
        FirstDigitEditFieldLabel     matlab.ui.control.Label
        PlotTab                      matlab.ui.container.Tab
        LoadFunctionButton           matlab.ui.control.Button
        FunctiontoPlotFxButtonGroup  matlab.ui.container.ButtonGroup
        absxButton                   matlab.ui.control.ToggleButton
        expxButton                   matlab.ui.control.ToggleButton
        sinxButton                   matlab.ui.control.ToggleButton
        UpperBoundEditField          matlab.ui.control.NumericEditField
        UpperBoundEditFieldLabel     matlab.ui.control.Label
        LowerBoundEditField          matlab.ui.control.NumericEditField
        LowerBoundEditFieldLabel     matlab.ui.control.Label
        UIAxes                       matlab.ui.control.UIAxes
    end

    % Callbacks that handle component events
    methods (Access = private)

        % Button pushed function: FindProductButton
        function FindProductButtonPushed(app, event)
              
            newVal = app.FirstDigitEditField.Value * app.SecondDigitEditField.Value;
            app.AnswerLabel.Text = sprintf("%.2f", newVal) ;
        end

        % Value changed function: ToggleLampButton
        function ToggleLampButtonValueChanged(app, event)
            value = app.ToggleLampButton.Value;
            if value == 0
                app.OffLabel.Text = "Off"
                app.ToggleLampButton.BackgroundColor = 'r';
            elseif value == 1
                app.OffLabel.Text = "On"
                app.ToggleLampButton.BackgroundColor = 'g';
            end
        end

        % Button pushed function: LoadFunctionButton
        function LoadFunctionButtonPushed(app, event)
            %
            if app.sinxButton.Value == true
                x = app.LowerBoundEditField.Value : 0.1: app.UpperBoundEditField.Value;
                y = sin(x);
                plot(app.UIAxes, x, y);
            end
            %
            if app.absxButton.Value == true
                a = app.LowerBoundEditField.Value : 0.1: app.UpperBoundEditField.Value;
                b = abs(a);
                plot(app.UIAxes, a, b);
            end
            
            if app.expxButton.Value == true
                c = app.LowerBoundEditField.Value : 0.1: app.UpperBoundEditField.Value;
                d = exp(c);
                plot(app.UIAxes, c, d);
            end
            
        end
    end

    % Component initialization
    methods (Access = private)

        % Create UIFigure and components
        function createComponents(app)

            % Create UIFigure and hide until all components are created
            app.UIFigure = uifigure('Visible', 'off');
            app.UIFigure.Position = [100 100 640 480];
            app.UIFigure.Name = 'MATLAB App';

            % Create TabGroup
            app.TabGroup = uitabgroup(app.UIFigure);
            app.TabGroup.Position = [1 1 640 480];

            % Create LampToggleTab
            app.LampToggleTab = uitab(app.TabGroup);
            app.LampToggleTab.Title = 'Lamp Toggle';

            % Create LampStatusLabel
            app.LampStatusLabel = uilabel(app.LampToggleTab);
            app.LampStatusLabel.Position = [263 328 76 22];
            app.LampStatusLabel.Text = 'Lamp Status:';

            % Create OffLabel
            app.OffLabel = uilabel(app.LampToggleTab);
            app.OffLabel.Position = [349 328 25 22];
            app.OffLabel.Text = 'Off';

            % Create ToggleLampButton
            app.ToggleLampButton = uibutton(app.LampToggleTab, 'state');
            app.ToggleLampButton.ValueChangedFcn = createCallbackFcn(app, @ToggleLampButtonValueChanged, true);
            app.ToggleLampButton.Text = 'Toggle Lamp';
            app.ToggleLampButton.BackgroundColor = [1 0 0];
            app.ToggleLampButton.Position = [263 277 100 22];

            % Create MultiplyTab
            app.MultiplyTab = uitab(app.TabGroup);
            app.MultiplyTab.Title = 'Multiply';

            % Create FirstDigitEditFieldLabel
            app.FirstDigitEditFieldLabel = uilabel(app.MultiplyTab);
            app.FirstDigitEditFieldLabel.HorizontalAlignment = 'right';
            app.FirstDigitEditFieldLabel.Position = [36 377 56 22];
            app.FirstDigitEditFieldLabel.Text = 'First Digit';

            % Create FirstDigitEditField
            app.FirstDigitEditField = uieditfield(app.MultiplyTab, 'numeric');
            app.FirstDigitEditField.Position = [107 377 100 22];

            % Create SecondDigitEditFieldLabel
            app.SecondDigitEditFieldLabel = uilabel(app.MultiplyTab);
            app.SecondDigitEditFieldLabel.HorizontalAlignment = 'right';
            app.SecondDigitEditFieldLabel.Position = [275 377 74 22];
            app.SecondDigitEditFieldLabel.Text = 'Second Digit';

            % Create SecondDigitEditField
            app.SecondDigitEditField = uieditfield(app.MultiplyTab, 'numeric');
            app.SecondDigitEditField.Position = [364 377 100 22];

            % Create FindProductButton
            app.FindProductButton = uibutton(app.MultiplyTab, 'push');
            app.FindProductButton.ButtonPushedFcn = createCallbackFcn(app, @FindProductButtonPushed, true);
            app.FindProductButton.Position = [126 298 138 52];
            app.FindProductButton.Text = 'Find Product';

            % Create AnswerLabel
            app.AnswerLabel = uilabel(app.MultiplyTab);
            app.AnswerLabel.Position = [364 313 46 22];
            app.AnswerLabel.Text = 'Answer';

            % Create PlotTab
            app.PlotTab = uitab(app.TabGroup);
            app.PlotTab.Title = 'Plot';

            % Create UIAxes
            app.UIAxes = uiaxes(app.PlotTab);
            title(app.UIAxes, 'Plotted Graph')
            xlabel(app.UIAxes, 'X')
            ylabel(app.UIAxes, 'F(x)')
            zlabel(app.UIAxes, 'Z')
            app.UIAxes.Position = [36 28 556 271];

            % Create LowerBoundEditFieldLabel
            app.LowerBoundEditFieldLabel = uilabel(app.PlotTab);
            app.LowerBoundEditFieldLabel.HorizontalAlignment = 'right';
            app.LowerBoundEditFieldLabel.Position = [16 328 76 22];
            app.LowerBoundEditFieldLabel.Text = 'Lower Bound';

            % Create LowerBoundEditField
            app.LowerBoundEditField = uieditfield(app.PlotTab, 'numeric');
            app.LowerBoundEditField.Position = [107 328 100 22];
            app.LowerBoundEditField.Value = -10;

            % Create UpperBoundEditFieldLabel
            app.UpperBoundEditFieldLabel = uilabel(app.PlotTab);
            app.UpperBoundEditFieldLabel.HorizontalAlignment = 'right';
            app.UpperBoundEditFieldLabel.Position = [16 377 76 22];
            app.UpperBoundEditFieldLabel.Text = 'Upper Bound';

            % Create UpperBoundEditField
            app.UpperBoundEditField = uieditfield(app.PlotTab, 'numeric');
            app.UpperBoundEditField.Position = [107 377 100 22];
            app.UpperBoundEditField.Value = 10;

            % Create FunctiontoPlotFxButtonGroup
            app.FunctiontoPlotFxButtonGroup = uibuttongroup(app.PlotTab);
            app.FunctiontoPlotFxButtonGroup.Title = 'Function to Plot F(x)';
            app.FunctiontoPlotFxButtonGroup.Position = [242 313 123 106];

            % Create sinxButton
            app.sinxButton = uitogglebutton(app.FunctiontoPlotFxButtonGroup);
            app.sinxButton.Text = 'sin(x)';
            app.sinxButton.Position = [11 53 100 22];
            app.sinxButton.Value = true;

            % Create expxButton
            app.expxButton = uitogglebutton(app.FunctiontoPlotFxButtonGroup);
            app.expxButton.Text = 'exp(x)';
            app.expxButton.Position = [11 32 100 22];

            % Create absxButton
            app.absxButton = uitogglebutton(app.FunctiontoPlotFxButtonGroup);
            app.absxButton.Text = 'abs(x)';
            app.absxButton.Position = [11 11 100 22];

            % Create LoadFunctionButton
            app.LoadFunctionButton = uibutton(app.PlotTab, 'push');
            app.LoadFunctionButton.ButtonPushedFcn = createCallbackFcn(app, @LoadFunctionButtonPushed, true);
            app.LoadFunctionButton.Position = [409 328 133 86];
            app.LoadFunctionButton.Text = 'Load Function';

            % Show the figure after all components are created
            app.UIFigure.Visible = 'on';
        end
    end

    % App creation and deletion
    methods (Access = public)

        % Construct app
        function app = FUF_App

            % Create UIFigure and components
            createComponents(app)

            % Register the app with App Designer
            registerApp(app, app.UIFigure)

            if nargout == 0
                clear app
            end
        end

        % Code that executes before app deletion
        function delete(app)

            % Delete UIFigure when app is deleted
            delete(app.UIFigure)
        end
    end
end