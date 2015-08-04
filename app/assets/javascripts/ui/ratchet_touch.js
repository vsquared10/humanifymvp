// See https://github.com/twbs/ratchet/blob/1e6600b995608da9474e8aa6288ba98ef083c20f/README.md#troubleshooting
_.each($('.touch'), function(element){
  new FingerBlast(element);
});
