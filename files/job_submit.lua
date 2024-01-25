--[[

Empty plugin, see https://slurm.schedmd.com/job_submit_plugins.html for more info

--]]

function slurm_job_submit(job_desc, part_list, submit_uid)
	return slurm.SUCCESS
end

function slurm_job_modify(job_desc, job_rec, part_list, modify_uid)
	return slurm.SUCCESS
end

slurm.log_info("job_submit.lua initialized")
return slurm.SUCCESS
