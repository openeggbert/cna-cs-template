#if !ENGINE_CNA
namespace CnaCsTemplate;

/// <summary>
/// A stand-in for CNA's <c>Microsoft.Xna.Framework.Graphics.GraphicsCapability</c> when this
/// template is built against MonoGame, FNA or Kni, none of which have a capability query.
///
/// Only the two identities this template actually asks about. XNA's model was two fixed profiles
/// where every conforming device supported everything in its profile, so there was nothing to ask;
/// CNA ships renderers that genuinely differ -- SDL_RENDERER is 2D-only -- which is why the
/// question exists at all on that engine and why this shim answers it statically here.
/// </summary>
internal enum GraphicsCapability
{
    ThreeD = 0,
    DepthStencilBuffer = 1,
}
#endif
