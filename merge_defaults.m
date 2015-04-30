function res = merge_defaults(params)
    defaults = default_params;
    provided_keys = keys(params);

    for index = 1:length(provided_keys)
        key = provided_keys{index};
        defaults(key) = params(key);
    end

    res = defaults;
end
