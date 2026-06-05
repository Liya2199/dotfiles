import pygame
from dataclasses import dataclass
import sys
# ===== CONSTANT =====
pygame.init()
WIDTH,HEIGHT= 800,600
@dataclass
class Player:
    x: int
    y: int
    size: int = 15
class Color:
    WHITE = (255,255,255)
    RED = (255,0,0)
    GREEN = (0,255,0)
    BLUE = (0,0,255)

# ===== MAIN ENTRY =====
screen = pygame.display.set_mode((WIDTH,HEIGHT))
pygame.display.set_caption("Demo")
clock = pygame.time.Clock()
running = True
player = Player(10,10)
while running:
    for event in pygame.event.get():
        if event.type == pygame.QUIT:
            running = False

    keys = pygame.key.get_pressed()
    if keys[pygame.K_LEFT] :
       player.x -= 10
    if keys[pygame.K_RIGHT] :
        player.x += 10
    
    player.x = max(0,min(WIDTH - player.size, player.x))
 
    screen.fill(Color.WHITE)

    pygame.draw.rect(screen,Color.RED,(player.x,player.y,player.size,player.size))
    pygame.display.flip()
    clock.tick(60)

pygame.quit()
sys.exit()
