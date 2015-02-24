// scrOnEntityLoadError(String error, Real httpStatus, Entity cachedCopy)

self.error = argument0;
if flox_entity_exists(self.entity) {
    flox_entity_free(self.entity);
}
self.entity = argument2;
