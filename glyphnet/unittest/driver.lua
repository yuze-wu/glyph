--[[
Unit test for GlyphNet driver component
Copyright 2016 Xiang Zhang
--]]

local Driver = require('driver')

--  A Logic Named Joe
local joe = {}

function joe.main()
   if joe.init then
      print('Initializing testing environment')
      joe:init()
   end
   for name, func in pairs(joe) do
      if type(name) == 'string' and type(func) == 'function'
      and name:match('[%g]+Test') then
         print('\nExecuting '..name)
         func(joe)
      end
   end
end

function joe:init()
   local config = dofile('config.lua')

   print('Creating driver')
   config.train_data.file = 'data/dianping/unittest_code.t7b'
   config.test_data.file = 'data/dianping/unittest_code.t7b'
   config.driver.debug = true
   config.driver.device = 3
   config.driver.steps = 10
   config.driver.epoches = 30
   config.driver.schedule = 4
   config.driver.variation = 'small'
   config.driver.location = '/tmp'
   local driver = Driver(config, config.driver)

   self.config = config
   self.driver = driver
end

function joe:driverTest()
   local driver = self.driver
   print('Training schedule')
   for i, v in pairs(driver.options.train.rates) do
      print(i, v)
   end
   print('Testing driver')
   driver:run()
end

joe.main()
return joe
