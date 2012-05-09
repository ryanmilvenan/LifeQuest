//
//  GLViewController.m
//  LifeQuest
//
//  Created by Ryan Milvenan on 4/25/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "GLViewController.h"

@interface GLViewController () {
    float _rotation;
    float _lightRotation;
    GLuint _vertexArray;
    GLuint _vertexBuffer;
    GLuint _indexBuffer;
}
@property (strong, nonatomic) EAGLContext *context;
@property (strong, nonatomic) GLKBaseEffect *effect;
@end

@implementation GLViewController
@synthesize context = _context;
@synthesize effect = _effect;

typedef struct {
    float Position[3];
    float Color[4];
    float TexCoord[2];
    float Normal[3];
} Vertex;

const Vertex Vertices[] = {
    //Front
    {   {1, -1, 1},    {1, 0, 0, 1},   {1, 0},  {0, 0, 1}  },
    {   {1, 1, 1},     {0, 1, 0, 1},   {1, 1},  {0, 0, 1}  },
    {   {-1, 1, 1},    {0, 0, 1, 1},   {0, 1},  {0, 0, 1}  },
    {   {-1, -1, 1},   {0, 0, 0, 1},   {0, 0},  {0, 0, 1}  },
    //Back
    {   {1, 1, -1},    {1, 0, 0, 1},   {0, 1},  {0, 0, -1} },
    {   {-1, -1, -1},  {0, 1, 0, 1},   {1, 0},  {0, 0, -1} },
    {   {1, -1, -1},   {0, 0, 1, 1},   {0, 0},  {0, 0, -1} },
    {   {-1, 1, -1},   {0, 0, 0, 1},   {1, 1},  {0, 0, -1} },
    //Left
    {   {-1, -1, 1},   {1, 0, 0, 1},   {1, 0},  {-1, 0, 0} },
    {   {-1, 1, 1},    {0, 1, 0, 1},   {1, 1},  {-1, 0, 0} },
    {   {-1, 1, -1},   {0, 0, 1, 1},   {0, 1},  {-1, 0, 0} },
    {   {-1, -1, -1},  {0, 0, 0, 1},   {0, 0},  {-1, 0, 0} },
    //Right
    {   {1, -1, -1},   {1, 0, 0, 1},   {1, 0},  {1, 0, 0}  },
    {   {1, 1, -1},    {0, 1, 0, 1},   {1, 1},  {1, 0, 0}  },
    {   {1, 1, 1},     {0, 0, 1, 1},   {0, 1},  {1, 0, 0}  },
    {   {1, -1, 1},    {0, 0, 0, 1},   {0, 0},  {1, 0, 0}  },
    //Top
    {   {1, 1, 1},     {1, 0, 0, 1},   {1, 0},  {0, 1, 0}  },
    {   {1, 1, -1},    {0, 1, 0, 1},   {1, 1},  {0, 1, 0}  },
    {   {-1, 1, -1},   {0, 0, 1, 1},   {0, 1},  {0, 1, 0}  },
    {   {-1, 1, 1},    {0, 0, 0, 1},   {0, 0},  {0, 1, 0}  },
    //Bottom
    {   {1, -1, -1},   {1, 0, 0, 1},   {1, 0},  {0, -1, 0} },
    {   {1, -1, 1},    {0, 1, 0, 1},   {1, 1},  {0, -1, 0} },
    {   {-1, -1, 1},   {0, 0, 1, 1},   {0, 1},  {0, -1, 0} },
    {   {-1, -1, -1},  {0, 0, 0, 1},   {0, 0},  {0, -1, 0} }
};

const GLubyte Indices[] = {
    //Front
    0, 1, 2,
    2, 3, 0,
    //Back
    4, 6, 5,
    4, 5, 7,
    //Left
    8, 9, 10,
    10, 11, 8,
    //Right
    12, 13, 14,
    14, 15, 12,
    //Top
    16, 17, 18,
    18, 19, 16,
    //Bottom
    20, 21, 22,
    22, 23, 20
};

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)setupGL {
    [EAGLContext setCurrentContext:self.context];
    glEnable(GL_CULL_FACE);
    self.effect = [[GLKBaseEffect alloc] init];
    
    /*
    NSDictionary *options = [NSDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithBool:YES], GLKTextureLoaderOriginBottomLeft, nil];
    
    NSError *error;
    NSString *path = [[NSBundle mainBundle] pathForResource:@"tile_floor" ofType:@"png"];
    GLKTextureInfo *info = [GLKTextureLoader textureWithContentsOfFile:path options:options error:&error];
    if (info == nil) {
        NSLog(@"Error loading file: %@", [error localizedDescription]);
    }
    self.effect.texture2d0.name = info.name;
    self.effect.texture2d0.enabled = true;
    
    path = [[NSBundle mainBundle] pathForResource:@"item_powerup_fish.png" ofType:nil];
    info = [GLKTextureLoader textureWithContentsOfFile:path options:options error:&error];
    if (info == nil) {
        NSLog(@"Error loading file: %@", [error localizedDescription]);
    }
    self.effect.texture2d1.name = info.name;
    self.effect.texture2d1.enabled = true;
    self.effect.texture2d1.envMode = GLKTextureEnvModeDecal;
    */
    
    self.effect.light0.enabled = GL_TRUE;
    self.effect.light0.diffuseColor = GLKVector4Make(0, 1, 1, 1.0);
    self.effect.light0.ambientColor = GLKVector4Make(0, 0, 0, 1);
    self.effect.light0.specularColor = GLKVector4Make(0, 0, 0, 1);
    
    self.effect.lightModelAmbientColor = GLKVector4Make(0, 0, 0, 1);
    self.effect.material.specularColor = GLKVector4Make(1, 1, 1, 1);
    
    self.effect.light0.position = GLKVector4Make(0, 1.5, -3, 1);
    
    self.effect.light1.enabled = GL_FALSE;
    self.effect.light1.diffuseColor = GLKVector4Make(1.0, 1.0, 0.8, 1.0);
    self.effect.light2.position = GLKVector4Make(0, 0, 1.5, 1);
    
    self.effect.lightingType = GLKLightingTypePerPixel;
    
    self.effect.fog.color = GLKVector4Make(0.5,0.5, 0.5, 1.0);
    self.effect.fog.enabled = YES;
    self.effect.fog.end = 5.5;
    self.effect.fog.start = 5;
    self.effect.fog.mode = GLKFogModeLinear;
    
    glGenVertexArraysOES(1, &_vertexArray);
    glBindVertexArrayOES(_vertexArray);
    
    glGenBuffers(1, &_vertexBuffer);
    glBindBuffer(GL_ARRAY_BUFFER, _vertexBuffer);
    glBufferData(GL_ARRAY_BUFFER, sizeof(Vertices), Vertices, GL_STATIC_DRAW);
    
    glGenBuffers(1, &_indexBuffer);
    glBindBuffer(GL_ELEMENT_ARRAY_BUFFER, _indexBuffer);
    glBufferData(GL_ELEMENT_ARRAY_BUFFER, sizeof(Indices), Indices, GL_STATIC_DRAW);
    
    glEnableVertexAttribArray(GLKVertexAttribPosition); 
    glVertexAttribPointer(GLKVertexAttribPosition, 3, GL_FLOAT, GL_FALSE, sizeof(Vertex), (const GLvoid *) offsetof(Vertex, Position)); 
    glEnableVertexAttribArray(GLKVertexAttribColor); 
    glVertexAttribPointer(GLKVertexAttribColor, 4, GL_FLOAT, GL_FALSE, sizeof(Vertex), (const GLvoid *) offsetof(Vertex, Color));
    /*
    glEnableVertexAttribArray(GLKVertexAttribTexCoord0);
    glVertexAttribPointer(GLKVertexAttribTexCoord0, 2, GL_FLOAT, GL_FALSE, sizeof(Vertex), (const GLvoid *) offsetof(Vertex, TexCoord));
    */
    glEnableVertexAttribArray(GLKVertexAttribNormal);
    glVertexAttribPointer(GLKVertexAttribNormal, 3, GL_FLOAT, GL_FALSE, sizeof(Vertex), (const GLvoid *) offsetof(Vertex, Normal));
    /*
    glEnableVertexAttribArray(GLKVertexAttribTexCoord1);
    glVertexAttribPointer(GLKVertexAttribTexCoord1, 2, GL_FLOAT, GL_FALSE, sizeof(Vertex), (const GLvoid*) offsetof(Vertex, TexCoord));
    */
    glBindVertexArrayOES(0);
}

- (void)tearDownGL {
    [EAGLContext setCurrentContext:self.context];
    self.effect = nil;
    
    glDeleteBuffers(1, &_vertexBuffer);
    glDeleteBuffers(1, &_indexBuffer);
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    self.context = [[EAGLContext alloc] initWithAPI:kEAGLRenderingAPIOpenGLES2];
    
    if(!self.context) {
        NSLog(@"Failed to create ES context");
    }
    
    GLKView *view = (GLKView *)self.view;
    view.context = self.context;
    view.drawableMultisample = GLKViewDrawableMultisample4X;
    [self setupGL];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    [self tearDownGL];
    if ([EAGLContext currentContext] == self.context) {
        [EAGLContext setCurrentContext:nil];
    }
    self.context = nil;
    // Release any retained subviews of the main view.
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    NSLog(@"timeSinceLastUpdate: %f", self.timeSinceLastUpdate);
    NSLog(@"timeSinceLastDraw: %f", self.timeSinceLastDraw);
    NSLog(@"timeSinceFirstResume: %f", self.timeSinceFirstResume);
    NSLog(@"timeSinceLastResume: %f", self.timeSinceLastResume);
    self.paused = !self.paused;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - GLKViewDelegate

- (void)glkView:(GLKView *)view drawInRect:(CGRect)rect {
    
    glClearColor(0.5, 0.5, 0.5, 1.0);
    glClear(GL_COLOR_BUFFER_BIT);
    
    [self.effect prepareToDraw];
    
    glBindVertexArrayOES(_vertexArray);
    glDrawElements(GL_TRIANGLES, sizeof(Indices)/sizeof(Indices[0]), GL_UNSIGNED_BYTE, 0);
}

#pragma mark - GLKViewControllerDelegate

- (void)update {    
    float aspect = fabsf(self.view.bounds.size.width / self.view.bounds.size.height);
    GLKMatrix4 projectionMatrix = GLKMatrix4MakePerspective(GLKMathDegreesToRadians(65.0f), aspect, 4.0f, 10.0f);
    self.effect.transform.projectionMatrix = projectionMatrix;
    GLKMatrix4 lightModelViewMatrix = GLKMatrix4MakeTranslation(0, 0, -6.0f);
    _lightRotation += -90 * self.timeSinceLastUpdate;
    lightModelViewMatrix = GLKMatrix4Rotate(lightModelViewMatrix, GLKMathDegreesToRadians(25), 1, 0, 0);
    lightModelViewMatrix = GLKMatrix4Rotate(lightModelViewMatrix, GLKMathDegreesToRadians(_lightRotation), 0, 1, 0);
    self.effect.transform.modelviewMatrix = lightModelViewMatrix;
    self.effect.light1.position = GLKVector4Make(0, 0, 1.5, 1);
    
    GLKMatrix4 modelViewMatrix = GLKMatrix4MakeTranslation(0.0f, 0.0f, -6.0f);
    _rotation += 90 * self.timeSinceLastUpdate; 
    modelViewMatrix = GLKMatrix4Rotate(modelViewMatrix, GLKMathDegreesToRadians(25), 1, 0, 0);
    modelViewMatrix = GLKMatrix4Rotate(modelViewMatrix, GLKMathDegreesToRadians(_rotation), 0, 1, 1);
    self.effect.transform.modelviewMatrix = modelViewMatrix;
}


@end
