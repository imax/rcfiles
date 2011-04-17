-- $Id: pc.lua,v 1.1.1.1 2001/04/18 14:55:49 max Exp $
-- vim:ft=lua:
-- MRSP commands implementation.
-- TODO: write more helpers and such.

commands.configure = {
	nargs = 0,
	level = 10,
	hint = 'Enter configuration mode',
	command = function(args)
		return ICR.NEW_PROMPT, push_stack('c')
	end
}

commands.c_hwprofile = {
	level = 50,
	command = function(args)
	end
}

commands.c_interface = {
	hint = 'Select an interface to configure',
	nargs = 2,
	helper = function(args)
		if args.n == 1 then
			local t = {}
			t.ethernet = 'Configure Ethernet interface'
			t.serial = 'Configure serial line interface'
			return t
		elseif args.n == 2 then
			local t = {}
			if strfind(args[1], '^[Ee]th') then
				for key,v in Service.hw.ethernet.values do
					local name = strsub(key, 4)
					t[name] = v.hint
				end
			elseif strfind(args[1], '^[Ss]er') then
				for key,v in Service.hw.serial.values do
					local name = strsub(key, 4)
					t[name] = v.hint
				end
			else
				t.ERROR='Unsupported interface type'
			end
			return t
		end
	end,
	command = function(args)
		if args.n ~= 2 then return ICR.WRONG_ARG_NO end
		local s = Service.interface
		if strfind(args[1], '^[sS]er') then
			args[1] = 'serial'
		end
		if strfind(args[1], '^[Ee]th') then
			args[1] = 'ethernet'
		end
		local ifname = s.resolve_iface(args[1], args[2])
		if not ifname then
			return ICR.WRONG_ARG, 'Unknown interface ' .. args[2]
		end
		-- load default values for this interface, if needed
		local param = Service.interface[args[1]]
		if param.values[ifname] == nil then
			param.values[ifname] = load_defaults(param.prototype)
			save_service_data('interface')
		end
		if args[1] == 'serial' then
			return ICR.NEW_PROMPT, push_stack('ser', ifname)
		else
			return ICR.NEW_PROMPT, push_stack('int', ifname)
		end
	end
}

commands['c_no ip routing'] = {
	hint = 'Disable IP routing',
	nargs = 0,
	command = function(args)
		return set_value(Service.netbase.routing, 'no', 'netbase')
	end
}

commands['c_no ip domain_lookup'] = {
	hint = 'Disable IP Domain Name System hostname translation',
	nargs = 0,
	command = function(args)
		return set_value(Service.netbase.nslookup, 'no', 'netbase')
	end
}

commands['c_no ip domain_name'] = {
	hint = 'Delete the default domain name',
	nargs = 0,
	command = function(args)
		return set_value(Service.netbase.domain_name, '', 'netbase')
	end
}

commands['c_no ip default_gateway'] = {
	hint = 'Delete default gateway',
	helper = function(args)
		local t={}
		for n,v in Service.routing.default_gateway.values do
			t[n]='IP address of default gateway'
		end
		return t
	end,
	command = function(args)
		return unset_list_value('routing', 'default_gateway', args)
	end
}

commands['c_no ip route'] = {
	hint = 'Delete static route',
	helper = function(args)
		local t={}	
	        for n,v in Service.routing.route.values do
			t[n]= 'gateway to ' .. v.gateway
		end
		return t
	end,
	command = function(args)
		return unset_list_value('routing', 'route', args)
	end
}

commands['c_no ip host'] = {
	hint = 'Delete an entry from the ip hostname table', 
	helper = function(args)
		local t = {}
		for key,val in Service.netbase.host.values do
			t[key] = val.address
		end
		return t
	end,
	command = function(args)
		return unset_list_value('netbase', 'host', args)
	end
}

commands['c_no ip name_server'] = {
        hint ='Delete the address of name server to use',
	helper = function(args)
		local t={}	
	        for n,v in Service.netbase.name_server.values do
			t[n]= 'IP address of name server'
		end
		return t
	end,
	command = function(args)
		return unset_list_value('netbase', 'name_server', args)
	end
}

commands['c_ip default_gateway'] = {
	hint ='Specify default gateway(if not routing IP)',
	nargs = 1,
	helper = function(args)
		local t={}
		t['A.B.C.D']='IP address of default gateway'
		return t
	end,
	command = function(args)
		local t = {name=args[1]}
		return apply_named_param('routing', 'default_gateway', t)
	end
}

commands['c_ip firewall'] = {
	hint ='Configure firewall settings',
	nargs = 0,
	command = function(args)
		return ICR.NEW_PROMPT, push_stack('fw', 'xxx')
	end
}

commands['c_ip route'] = {
	hint ='Establish static routes',
	nargs = 3,
	helper = function(args)
		if args.n==1 then
			local t={}
			t['A.B.C.D']='Destination prefix'
			return t
		elseif args.n==2 then
			local t={}		
			t['A.B.C.D']='Destination prefix mask'
			return t	
		elseif args.n==3 then
			local t={}
			t['A.B.C.D']='Forwarding router\'s address'
			return t
		end
	end,
	command = function(args)
		local t = {name=args[1], mask=args[2], gateway=args[3]}
		return apply_named_param('routing', 'route', t)
	end
}

commands['c_ip host'] = {
	hint ='Add an entry to the ip hostname table',
	nargs = 2,
	helper = function(args)
		if args.n==1 then
			local t={}
			t.WORD = 'Host name'
			return t
		elseif args.n==2 then
			local t={}		
			t['A.B.C.D']='Host IP address'
			return t	
		end
	end,
	command = function(args)
		local t = {name=args[1], address=args[2]}
		return apply_named_param('netbase', 'host', t)
	end
}

commands['c_ip routing'] = {
	hint ='Enable IP routing',
	nargs = 0,
	command = function(args)
		return set_value(Service.netbase.routing, 'yes', 'netbase')
	end
}

commands['c_ip name_server'] = {
	hint ='Specify address of name server to use',
	nargs = 1,
        helper = function(args)               
            local t={}            
            t['A.B.C.D']='IP address of name server'     
            return t              
	end,                                  	
	command = function(args)
		local t = {name=args[1]}
		return apply_named_param('netbase', 'name_server', t)
	end
}

commands['c_ip domain_lookup'] = {
	hint='Enable IP Domain Name System hostname translation',
	nargs = 0,
	command = function(args)
		return set_value(Service.netbase.nslookup, 'yes', 'netbase')
	end
}

commands['c_ip domain_name'] = {
	hint='Define the default domain name',
	nargs = 1,
        helper = function(args)               
            local t={}            
            t['WORD']='Default domain name'     
            return t              
	end,                                  	
	command = function(args)
		return set_value(Service.netbase.domain_name, args[1], 'netbase')
	end
}

commands.c_exit = {
	hint = 'Exit from configure mode',
	command = function(args)
		return exit_current_level()
	end
}

commands.date = {
	nargs = 0,
	hint = 'Current time on the router',
	--helper = function(args)
	command = function(args)
		return ICR.TEXT, date()
	end
}

commands.c_hostname = {
	nargs = 1,
	level = 10,
	hint = 'Set system\'s network name',
	helper = function(args)
	    return {WORD='Network name'}
	end,
	command = function(args)
	return set_value(Service.netbase.hostname, args[1], 'netbase')
end
}

commands['c_clock set'] = {
	hint = 'Set system time and date',
	nargs = 1,
	helper = function(args)
		if args.n==1 then
			local t={}
			t['hh:mm:ss']='Current time'
			return t
		elseif args.n==2 then
			local t={}
			t['<1-31>']='Day of the month'
			t.MONTH='Month of the year'
			return t		
		elseif args.n==3 then
			--local t={}
			--if months[args[2]] then	
			--	t['<1-31>']='Day of the month'
			--else
			--	t.MONTH='Month of the year'
			--end	
			--return t	
		elseif args.n==4 then
			local t={}
			t['<1993-2035>']='Year'
			return t	
		end
	end,
	command = function(args)
		local rc, err = syscmd("date >/dev/null -s " .. args[1])
		if rc ~= 0 then return ICR.WRONG_ARG, err end
		Execute("hwclock --systohc")
		return ICR.OK
	end
}

commands.telnet = {
	hint = 'Open a telnet connection',
	level = 10,
	helper = function(args)
		if args.n == 1 then
			return {WORD='IP address or hostname of a remote system'}
		elseif args.n == 2 then
			return {PORT='Port to connect (as number or as protocol name)'}
		end
	end,
	command = function(args)
		if args.n < 1 or args.n > 2 then
			return ICR.WRONG_ARG_NO
		end
		local s = 'telnet ' .. args[1]
		if args[2] then s = s .. ' ' .. args[2] end
		return ICR.SVCCMD, s
	end
}

commands.ping = {
	nargs = 1,
	hint = 'Send echo messages',
	helper = function(args)
		if args.n == 1 then
			local t={}
			t['A.B.C.D']='Host IP address'
			t.WORD='Host name'
			return t
		end
	end,
	command = function(args)
		return ICR.SVCCMD, 'ping -c5 ' .. args[1]
	--local rc, output = syscmd("ping -c 10 " .. args[1])
	--return ICR.TEXT, output
end
}

commands['show clock'] = {
	nargs = 0,
	hint = 'Display the system clock',
	command = function(args)
		return ICR.TEXT, date()
	end
}

commands['show hardware'] = {
	nargs = 0,
	hint = 'Show hardware profile',
	command = function(args)
		local s = 'Hardware profile:\n'
		return ICR.TEXT, s
	end
}

commands['show interface state'] = {
	hint = 'Show interfaces statistics',
	nargs = 0,
	command = function(args)
		t = read_stat()
		local rc, err = syscmd("/sbin/ifconfig")
		return ICR.TEXT, err
	end
}

commands['show location'] = {
	nargs = 0,
	hint = 'Show location of this router',
	command = function(args)
		return ICR.TEXT, Service.snmpd.syslocation.value
	end
}

commands.syscmd = {
	hint = 'Execute UNIX command',
	nargs = 1,
	level = 50,
	command = function(args)
	local rc, output = syscmd(args[1])
	if rc == nil then
		return ICR.FAILED, "Failed to execute " .. args.raw
	end
	return ICR.TEXT, output
end
}

commands._kill = {
	nargs = 2,
	level = 11,
	hint = 'Kill process by its PID',
	command = function(args)
	send_signal(args[1], args[2])
	return ICR.OK
end
}

commands.write = {
	nargs = 1,
	level = 10,
	hint = 'Save current profile',
	--helper = function(args)
	command = function(args)
	return ICR.KEYW_UNIMPL
end
}

commands.exit = {
	nargs = 0,
	hint = 'Exit configuration program',
	--helper = function(args)
	command = function(args)
		commands.quit.command(args)
	end
}

commands.quit = {
	nargs = 0,
	hint = 'Exit the configuration program',
	command = function(args)
		Log("Exit mainloop on user request; memory usage %s", gcinfo())
		exit()
	end,
}
