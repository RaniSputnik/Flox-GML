// scrOnEntityDestroyComplete()

if flox_entity_exists(self.entity) {
    flox_entity_free(self.entity);
}
self.entity = noone;
