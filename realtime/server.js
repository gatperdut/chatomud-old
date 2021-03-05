var io    = require('socket.io').listen(process.env.CM_NODEJS_PORT),
    redis = require('redis').createClient('6379', process.env.CM_REDIS_HOST, {});

redis.on('error', function (err) {
  console.error(err);
});

redis.setMaxListeners(0);

io.on('connection', function(socket){
  socket.on('subscribe_channel', function(msg) {
    msg.channels.forEach(function(channel) {
      console.log('Subscribing for channel ' + channel);
      result = redis.subscribe(channel);
      console.log('Result for channel ' + channel + ' was ' + result);
      socket.emit('subscribe_channel', 'Result for channel ' + channel + ' was ' + result);
    });
  });

  socket.on('healthcheck', function(msg) {
    if(msg == 'CHECK') {
      socket.emit('healthcheck_confirmation', 'OK');
    }
  });

  //socket.on('disconnect', function(msg){
  //  console.log(socket.id);
  //});

  redis.on('message', function(channel, msg) {
    socket.emit(channel, msg);
  });
});
