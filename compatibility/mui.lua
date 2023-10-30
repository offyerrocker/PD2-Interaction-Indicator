local ii = InteractionIndicator

Hooks:PostHook(MUIInteract,"show_interact","interactionindicator_showinteract",callback(ii,ii,"OnStartMouseoverInteractable"))
Hooks:PostHook(MUIInteract,"remove_interact","interactionindicator_removeinteract",callback(ii,ii,"OnStopInteraction"))
Hooks:PostHook(MUIInteract,"show_interaction_bar","interactionindicator_showinteractionbar",callback(ii,ii,"OnInteractionStart"))
Hooks:PostHook(MUIInteract,"set_interaction_bar_width","interactionindicator_setinteractionprogress",callback(ii,ii,"SetInteractionProgress"))
Hooks:PostHook(MUIInteract,"hide_interaction_bar","interactionindicator_hideinteractionbar",callback(ii,ii,"OnInteractionEnd"))
Hooks:PostHook(MUIInteract,"set_bar_valid","interactionindicator_setbarvalid",callback(ii,ii,"SetInteractTextValid"))