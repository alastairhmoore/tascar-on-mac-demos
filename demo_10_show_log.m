[fn, pn] = uigetfile('.mat','Select mat file with LSL streams');
lsl_data_path = fullfile(pn, fn);
lsl_data = load(lsl_data_path);

%%
fprintf('Found the following streams:\n')
cellfun(@(c)fprintf('\t%s\n',c),lsl_data.names)

%%
figure;
tiledlayout('flow')
for ii = 1:length(lsl_data.data)
    axh = nexttile();
    if ~isempty(lsl_data.data{ii}.data)
        if ismember('lsl_type',fieldnames(lsl_data.data{ii}))
            switch lsl_data.data{ii}.lsl_type
                case 'time'
                    plot(axh,lsl_data.data{ii}.data(2,:).',...
                        lsl_data.data{ii}.data(3,:).');
                case 'position'
                    plot(axh,lsl_data.data{ii}.data(2,:).',...
                        lsl_data.data{ii}.data(3:8,:).');
                    legend({'x','y','z','rotZ','rotY','rotX'})
                case 'level'
                    plot(axh,lsl_data.data{ii}.data(2,:).',...
                        lsl_data.data{ii}.data(3:end,:).');
            end
        end
        title(axh,sprintf('%s - %s',...
                            lsl_data.data{ii}.lsl_name,...
                            lsl_data.data{ii}.lsl_type))
    else
        title(axh,lsl_data.names{ii})
    end
    
end