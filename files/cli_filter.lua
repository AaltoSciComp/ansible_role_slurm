--[[

Empty plugin, see https://slurm.schedmd.com/cli_filter_plugins.html for more info

--]]

function slurm_cli_pre_submit(options, pack_offset)
	return slurm.SUCCESS
end

function slurm_cli_setup_defaults(options, early_pass)
	return slurm.SUCCESS
end

function slurm_cli_post_submit(offset, job_id, step_id)
	return slurm.SUCCESS
end
