chai = require 'chai'
sinon = require 'sinon'
chai.use require 'sinon-chai'

expect = chai.expect

describe 'spotify', ->
  user =
    name: 'user'
    id: 'U123'
  robot =
    respond: sinon.spy()
    hear: sinon.spy()
    brain:
      on: (_, cb) ->
        cb()
      data: {}
      userForName: (who) ->
        forName =
          name: who
          id: 'U234'

  beforeEach ->
    @user = user
    @robot = robot
    @data = @robot.brain.data
    @msg =
      send: sinon.spy()
      reply: sinon.spy()
      envelope:
        user:
          @user
      message:
        user:
          @user

  require('../src/spotify')(robot)

  it 'registers a respond listener for albums', ->
    expect(@robot.respond).to.have.been.calledWith(/spotify album( me)? (.*)/i)

  it 'registers a respond listener for artists', ->
    expect(@robot.respond).to.have.been.calledWith(/spotify artist( me)? (.*)/i)
    
  it 'registers a respond listener for tracks', ->
    expect(@robot.respond).to.have.been.calledWith(/spotify track( me)? (.*)/i)  