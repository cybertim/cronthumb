Sequelize = require 'sequelize'
config = require './config.coffee'

sequelize = new Sequelize config.db_name, '', '', dialect: 'sqlite', storage: config.db_file, logging: false

Thumb = sequelize.define 'Thumb',
  original: Sequelize.STRING
  thumb: Sequelize.STRING
  done: Sequelize.BOOLEAN
  error: Sequelize.BOOLEAN
  queued: Sequelize.BOOLEAN

sequelize.sync()

module.exports = {
  Thumb: Thumb
}
